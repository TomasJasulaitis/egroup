<?php
 
class Users{
	//DB stuff
	private $conn;

	public $functions_name;
	public $users_nickname;

	//Contruct with DB
	public function __construct($db){
		$this->conn = $db;
	}


	/* 
	1st Select - checks for user -> function
	2nd Select - checks for user -> group -> function
	3rd Select - checks for user -> module -> function
	4th Select - checks for user -> group -> module -> function
	*/

	public function check_rights(){
		$query = "
			SELECT DISTINCT 
		((SELECT 1
	        FROM users
	        JOIN functions ON functions.user_id = users.id
		WHERE functions.name = :functions_name 
	        AND users.nickname = :users_nickname)

	    	OR 
	        (SELECT 1
		FROM groups
	    	JOIN users ON groups.user_id = users.id
	        JOIN functions ON functions.group_id = groups.id
		WHERE functions.name = :functions_name
	        AND users.nickname = :users_nickname)
		OR

	    	(SELECT 1
		FROM  modules
          	JOIN users on users.id = modules.user_id
           	JOIN functions on functions.module_name = 
          	(SELECT modules.name 
	                FROM modules, users 
			WHERE users.modules_id IN (modules.id))
	        AND functions.name  = :functions_name
	        AND users.nickname = :users_nickname)

	    	OR
	    	(SELECT 1
		FROM groups
	        JOIN users ON users.groups_id = groups.id
            	JOIN modules ON modules.group_id = groups.id
            	JOIN functions on functions.module_name = 
            	(SELECT modules.name 
			FROM modules, groups 
		    	WHERE groups.module_id IN (modules.id))
     		AND functions.name  = :functions_name
	        AND users.nickname = :users_nickname)) as allowed
		FROM users
   
	 		";
		$stmt = $this->conn->prepare($query);
		//binding data and executing query
		$stmt->execute(array(':functions_name' => $this->functions_name,
						     ':users_nickname' => $this->users_nickname	));
		
		//fetching rows returned
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
		//returning result from query 
		return $row['allowed'];
	}
}


?>
