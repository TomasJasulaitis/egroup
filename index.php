<?php 

include_once 'config/database.php';
include_once 'models/users.php';


//Instantiate DB and connect
$database = new Database();
$db = $database->connect();

//Instantiate users object
$users = new Users($db);

//message assignment
if(isset($_GET['message']) && ($_GET['message'] != null)){
    switch($_GET['message']){
        case 'success':
            echo "<div class='alert alert-success'> User is allowed to use the function </div>";
            break;
        case 'failure':
            echo "<div class='alert alert-danger'> User is now allowed to use the function </div>";
            break;
        case 'empty':
            echo "<div class='alert alert-danger'> Please fill in all the fields. </div>";
            break;
        default: 
            break;
    }
}


//Checks if anything was writen in the forms
if($_POST){

    //Set users properties from the form
    $users->users_nickname = $_POST['users_nickname'];
    $users->functions_name =$_POST['functions_name'];

    //checks if fields are not empty
    if(empty($_POST['users_nickname'])||empty($_POST['functions_name'])){
    	header("Location: index.php?message=empty");
    }
    
    if($users->check_rights() == 1){
        header("Location: index.php?message=success");
    }
    else{ 
        header("Location: index.php?message=failure");
 	}
}
?> 



<!DOCTYPE html>
<html lang="en">
<head>
 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<style>
body{
	background-color: #ccf5ff;
}
</style>
</head>
<body>



<form action="index.php" method="POST" role="form" class="form-horizontal">
  <div class="form-group col-sm-10">
    <label for="users_nickname" class="col-sm-2 control-label">Choose nickname</label>
    <select name="users_nickname" class="form-control">
      <option value="tomjas"> tomjas </option>
      <option value="petlauk">petlauk </option>
      <option value="tomjan"> tomjan </option>
      <option value="petluk"> petluk </option>
    </select>
  </div>
 <div class="form-group col-sm-10">
    <label for="functions_name" class="col-sm-2 control-label">Choose function</label>
    <select name="functions_name" class="form-control">
      <option value="funkcija 1"> funkcija 1 </option>
      <option value="funkcija 2"> funkcija 2 </option>
      <option value="funkcija 3"> funkcija 3 </option>
      <option value="funkcija 4"> funkcija 4 </option>
    </select>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Search</button>
    </div>
  </div>
</form>

</body>