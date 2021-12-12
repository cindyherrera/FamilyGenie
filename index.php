<!DOCTYPE html>
<html lang="en">
<head>
  <title>Landing Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container-fluid">
  <div class="row content">
    <div class="col-sm-3 sidenav">
      <h4 >Family Genie</h4>
        <ul class="nav nav-pills nav-stacked">
            <li class="active"><a href="#section1">Home</a></li>
            <li><a href="family.html">Family</a></li>
            <li><a href="#">fillerText</a></li>
            <li><a href="testmysql.php">Test DB connection</a></li>
        </ul><br>
    </div>
    <div class="col-sm-9">Upcoming Events</small></h4>
      <hr>
      <h2>Database Final Exam</h2>
      <h5><span class="glyphicon glyphicon-time"></span> Post by Brittany.</h5>
      <p>2021-12-06 19:15:00</p>
      <p>Do not forget to take the database final exam</p>
      <br><br>
      <h4><small>RECENT POSTS</small></h4>
      <hr>
      <h2>Database Group Project Due</h2>
      <h5><span class="glyphicon glyphicon-time"></span> Post by Brittany</h5>
      <p>2021-12-12 23:59:59</p>
      <p>Please submit your final Database project!!!</p>
      <hr> 
      <br><br>
</div>
<!-- (B) LIST -->
<div class="container-fluid">
     <!-- (A) HEADER -->
     <h1>Family Members</h1>


<div id="list"><?php
    // (B1) LOAD LIBRARY
    require "database_link.php";

    // (B2) PROCESS DELETE ENTRY
    if (isset($_GET["del"])) {
      if ($_AB->del($_GET["del"])) {
        echo "<div class='note'>Entry deleted</div>";
      } else {
        echo "<div class='note'>".$_AB->error."</div>";
      }
    }

    // (B3) LIST ENTRIES
    $entries = $_AB->get();
    if (is_array($entries)) { foreach ($entries as $ab) { ?>
    <div class="row">
      <div class="colA">
        <strong><?=$ab["first_name"]?> <?=$ab["middle_name"]?> <?=$ab["last_name"]?></strong><br>
        <?=$ab["birth_date"]?>
      </div>
      <div class="input-group">
        <input type="button" value="Edit" onclick="location.href='4-entry.php?id=<?=$ab["person_Id"]?>'"/> 
        <input type="button" value="Delete" onclick="location.href='index.php?del=<?=$ab["person_Id"]?>'"/>
      </div>
    </div>
    <?php }} else { echo "No entries found."; }
    ?></div>
    <br>
    <input type="button" value="Add Entry" onclick="location.href='4-entry.php'"/>
</div>

</body>
</html>
