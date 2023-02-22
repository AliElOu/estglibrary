<?php 
$conn=new mysqli("sql104.epizy.com","epiz_33600479","JKAlyyu8wBOWv9","epiz_33600479_pfe_library");
$email = $_POST['email'];
$pass = md5($_POST['password']);
$sqlqu = "select * from etudiant where email='$email' and pass = '$pass'";
$result = mysqli_query($conn,$sqlqu);
$count= mysqli_num_rows();

?>