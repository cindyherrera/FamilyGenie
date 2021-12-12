<?php
class FamilyGenie {
  // (A) CONSTRUCTOR - CONNECT TO DATABASE
  private $pdo = null;
  private $stmt = null;
  public $lastID = null;
  public $error = "";
  function __construct () {
    try {
      $this->pdo = new PDO(
        "mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=".DB_CHARSET,
        DB_USER, DB_PASSWORD, [
          PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
          PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]
      );
    } catch (Exception $ex) { exit($ex->getMessage()); }
  }

  // (B) DESTRUCTOR - CLOSE DATABASE CONNECTION
  function __destruct () {
    if ($this->stmt!==null) { $this->stmt = null; }
    if ($this->pdo!==null) { $this->pdo = null; }
  }

  // (C) SAVE ENTRY
  function save ($name, $middle_name, $last_name, $gender, $dob, $id=null) {
    // (C1) ADD NEW
    if ($id===null) {
      //$sql = "INSERT INTO `person` (`name`, `middle_name`, `last_name`, `genderess`) VALUES (?,?,?,?)";
      $sql = "INSERT INTO `person` (`first_name`, `middle_name`,`last_name`, `gender`,`birth_date`) VALUES (?,?,?,?,?)";
      $data = [$name, $middle_name, $last_name, $gender, $dob];
    }
    // (C2) UPDATE
    else {
      $sql = "UPDATE `person` SET `first_name`=?, `middle_name`=?, `last_name`=?, `gender`=?, `birth_date` WHERE `person_Id`=?";
      $data = [$name, $middle_name, $last_name, $gender, $dob];
    }
    // (C3) RUN SQL
    try {
      $this->stmt = $this->pdo->prepare($sql);
      $this->stmt->execute($data);
      $this->lastID = $this->pdo->lastInsertId();
      return true;
    } catch (Exception $ex) {
      $this->error = $ex->getMessage();
      return false;
    }
  }

  // (D) DELETE ENTRY
  function del ($id) {
    try {
      $this->stmt = $this->pdo->prepare("DELETE FROM `person` WHERE `person_Id`=?");
      $this->stmt->execute([$id]);
      return true;
    } catch (Exception $ex) {
      $this->error = $ex->getMessage();
      return false;
    }
  }

  // (E) GET ENTRY
  function get ($id=null) {
    $sql = "SELECT * FROM `person`" . ($id==null ? "" : " WHERE `id`=?");
    $data = $id==null ? null : [$id];
    $this->stmt = $this->pdo->prepare($sql);
    $this->stmt->execute($data);
    return $id==null ? $this->stmt->fetchAll() : $this->stmt->fetch() ;
  }
}

// (F) DATABASE SETTINGS - CHANGE TO YOUR OWN!
define("DB_HOST", "localhost");
define("DB_NAME", "family_genie");
define("DB_CHARSET", "utf8mb4");
define("DB_USER", "root");
define("DB_PASSWORD", "");

// (G) NEW TO-DO OBJECT
$_AB = new FamilyGenie();

/* TEST FOR YOURSELF!
echo $_AB->save("Jon", "jon@doe.com", "12345678", "12 Test Street")
? "OK" : $_AB->error;
echo $_AB->save("Jone", "jone@doe.com", "87654321", "34 Test Street")
? "OK" : $_AB->error;
$all = $_AB->get();
print_r($all);*/
