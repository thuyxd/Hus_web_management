<?php
  // Initialize the session
  session_start();

  // Check if the user is already logged in, if yes then redirect him to welcome page
  if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true) {
    header("location: ../welcome.php");
    exit;
  }

  // Include config file
  require_once "../config.php";

  // Define variables and initialize with empty values
  $username = $password = $name_organization = "";
  $username_err = $password_err = "";

  // Processing form data when form is submitted
  if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Check if username is empty
    if (empty(trim($_POST["username"]))) {
      $username_err = "Please enter username.";
    } else {
      $username = trim($_POST["username"]);
    }

    // Check if password is empty
    if (empty(trim($_POST["password"]))) {
      $password_err = "Please enter your password.";
    } else {
      $password = trim($_POST["password"]);
    }

    // Validate credentials
    if (empty($username_err) && empty($password_err)) {
      // Prepare a select statement
      $sql = "SELECT id, username, name_organization, password FROM organization_profile WHERE id = ?";

      if ($stmt = mysqli_prepare($link, $sql)) {
        
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "s", $param_username);

        // Set parameters
        $param_username = $username;

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt)) {
          // Store result
          mysqli_stmt_store_result($stmt);
          // Check if username exists, if yes then verify password
          if (mysqli_stmt_num_rows($stmt) == 1) {
            // Bind result variables
            mysqli_stmt_bind_result($stmt, $id, $username, $name_organization, $hashed_password);
            if (mysqli_stmt_fetch($stmt)) {
              if (password_verify($password, $hashed_password)) {
                // Password is correct, so start a new session
                session_start();

                // Store data in session variables
                $_SESSION["loggedin"] = true;
                $_SESSION["id"] = $id;
                $_SESSION["username"] = $username;
                $_SESSION["name_organization"] = $name_organization;

                // Redirect user to welcome page
                header("location: ../welcome.php");
              } else {
                // Display an error message if password is not valid
                $password_err = "The password you entered was not valid.";
              }
            }
          } else {
            // Display an error message if username doesn't exist
            $username_err = "No account found with that username.";
          }
        } else {
          echo "Oops! Something went wrong. Please try again later.";
        }
        // Close statement
        mysqli_stmt_close($stmt);
      }
    }

    // Close connection
    mysqli_close($link);
  }
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <style>
    body {
      font-family: Arial, Helvetica, sans-serif;
      text-align: center;
    }

    button:hover {
      opacity: 0.8;
    }

    /* Extra styles for the cancel button */
    .custom-btn {
      width: auto;
      padding: 10px 18px;
      background-color: #f44336;
    }

    span.password {
      float: right;
      padding-top: 16px;
    }

    /* The Modal (background) */
    .modal {
      background-color: rgba(0, 0, 0, 0.4);
      /* Black w/ opacity */
    }

    /* Modal Content/Box */
    .modal-content {
      margin: 5% auto 15% auto;
      /* 5% from the top, 15% from the bottom and centered */
      width: 40%;
      /* Could be more or less, depending on screen size */
    }

    /* Add Zoom Animation */
    .animate {
      -webkit-animation: animatezoom 0.6s;
      animation: animatezoom 0.6s
    }

    @-webkit-keyframes animatezoom {
      from {
        -webkit-transform: scale(0)
      }

      to {
        -webkit-transform: scale(1)
      }
    }

    @keyframes animatezoom {
      from {
        transform: scale(0)
      }

      to {
        transform: scale(1)
      }
    }

    /* Change styles for span and cancel button on extra small screens */
    @media screen and (max-width: 300px) {
      span.password {
        display: block;
        float: none;
      }

      .custom-btn {
        width: 100%;
      }
    }
  </style>
</head>

<body>
  <h1>ORGANIZATION</h1>
  <h2>Login Form</h2>
  <button onclick="document.getElementById('dialog').style.display='block'" class="w3-button w3-blue">Login</button>
  <div id="dialog" class="modal">
    <form class="modal-content animate"  action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
      <div class="w3-padding-large">
        <div class="form-group <?php echo (!empty($username_err)) ? 'has-error' : ''; ?>">
          <label for="userName"><b>User Name</b></label>
          <input class="w3-input w3-padding-large" type="text" placeholder="Enter Username" name="username" value="<?php echo $username; ?>" required>
          <span class="w3-text-red"><?php echo $username_err; ?></span>
        </div>
        <div class="form-group <?php echo (!empty($password_err)) ? 'has-error' : ''; ?>">
          <label for="password"><b>Password</b></label>
          <input class="w3-input w3-padding-large" type="password" placeholder="Enter Password" name="password" required>
          <span class="w3-text-red"><?php echo $password_err; ?></span>
        </div>
        <button type="submit" class="w3-button w3-blue w3-block">Login</button>
        <!-- <label>
          <input type="checkbox" checked="checked" name="remember"> Remember me
        </label> -->
        <p>Don't have an account? <a href="../register/organization.php">Sign up now</a>.</p>
      </div>
      <div class="w3-padding" style="background-color:#f1f1f1">
        <button type="reset" class="w3-btn w3-red">Reset</button>
        <button type="button" onclick="document.getElementById('dialog').style.display='none'"  class="w3-btn w3-blue-gray">Cancel</button>
      </div>
    </form>
  </div>
  <script>
    // Get the modal
    var modal = document.getElementById('dialog');
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
  </script>
</body>

</html>