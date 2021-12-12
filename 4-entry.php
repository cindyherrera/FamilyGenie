<!DOCTYPE html>
<html>
  <head>
    <title>Person Entry</title>
    <link rel="stylesheet" href="style.css">
    <style>
    html, body, input, textarea { font-family: arial, sans-serif; font-size: 18px; }
    .note {
      padding: 10px;
      margin-bottom: 10px;
      background: #e2eaff;
    }
    #abform {
      box-sizing: border-box;
      width: 100%;
      max-width: 500px;
      padding: 10px;
      border: 1px solid #eee;
      background: #f7f7f7;
    }
    input[type="button"], input[type="submit"] {
      border: 0;
      margin: 5px;
      padding: 10px;
      background: #3956e3;
      color: #fff;
      cursor: pointer;
    }
    #abform label {
      display: block;
      padding: 10px 0;
      color: #858585;
    }
    #abform input, #abform textarea {
      box-sizing: border-box;
      width: 100%;
      padding: 5px;
    }
    </style>
  </head>
  <body>
    <?php
    // (A) LOAD DATABASE
    require "database_link.php";

    // (B) PROCESS SAVE
    if (isset($_POST["first_name"])) {
      if ($_AB->save($_POST["first_name"], $_POST["middle_name"], $_POST["last_name"],
      $_POST["gender"],$_POST["dob"], (isset($_GET["person_Id"])?$_GET["person_Id"]:null))) {
        header("Location: 4-entry.php?s=1&id=" . (isset($_GET["person_Id"])?$_GET["person_Id"]:$_AB->lastID));
        exit();
      } else { echo "<div class='note'>{$_AB->error}</div>"; }
    }
    if (isset($_GET["s"])) { echo "<div class='note'>Entry Saved</div>"; }

    // (C) ADDRESS BOOK ENTRY FORM
    if (isset($_GET["person_Id"])) { $entry = $_AB->get($_GET["person_Id"]); } ?>
    <form id="abform" method="post">
      <label for="first_name">First Name</label>
      <input type="text" name="first_name" required value="<?=isset($entry)?$entry["first_name"]:""?>"/>

      <label for="middle_name">Middle Name</label>
      <input type="middle_name" name="middle_name" required value="<?=isset($entry)?$entry["middle_name"]:""?>"/>

      <label for="last_name">Last Name</label>
      <input type="text" name="last_name" required value="<?=isset($entry)?$entry["last_name"]:""?>"/>

      <label for="gender">Gender</label>
      <textarea name="gender" required/><?=isset($entry)?$entry["gender"]:""?></textarea>

      <label for="dob">dob</label>
      <textarea name="dob" required/><?=isset($entry)?$entry["dob"]:""?></textarea>

      <input type="submit" value="Save"/>
      <input type="button" value="Back" onclick="location.href='index.php'"/>
    </form>
  </body>
</html>
