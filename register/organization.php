<?php
  // Include config file
  require_once "../config.php";

  // Define variables and initialize with empty values
  $username = $name_organization = $tax = $email = $address = $password = $confirm_password = "";
  $username_err = $name_organization_err = $tax_err = $email_err = $address_err = $password_err = $confirm_password_err = "";

  // Processing form data when form is submitted
  if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Validate username
    if (empty(trim($_POST["username"]))) {
      $username_err = "Please enter a username.";
    } else {
      // Prepare a select statement
      $sql = "SELECT id FROM orrganization_profile WHERE id = ?";

      if ($stmt = mysqli_prepare($link, $sql)) {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "s", $param_username);

        // Set parameters
        $param_username = trim($_POST["username"]);

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt)) {
          /* store result */
          mysqli_stmt_store_result($stmt);

          if (mysqli_stmt_num_rows($stmt) == 1) {
            $username_err = "This organization id is already taken.";
          } else {
            $username = trim($_POST["username"]);
          }
        } else {
          echo "Oops! Something went wrong. Please try again later.";
        }
      }

      // Close statement
     // mysqli_stmt_close($stmt);
    }

    // Validate password
    if (empty(trim($_POST["password"]))) {
      $password_err = "Please enter a password!";
    } elseif (strlen(trim($_POST["password"])) < 6) {
      $password_err = "Password must have atleast 6 characters.";
    } else {
      $password = trim($_POST["password"]);
    }

    // Validate confirm password
    if (empty(trim($_POST["confirm_password"]))) {
      $confirm_password_err = "Please confirm password!";
    } else {
      $confirm_password = trim($_POST["confirm_password"]);
      if (empty($password_err) && ($password != $confirm_password)) {
        $confirm_password_err = "Password did not match!";
      }
    }

    // Validate tax
    if (empty(trim($_POST["tax"]))) {
      $tax_err = "Please enter your tax number!";
    } elseif (strlen(trim($_POST["tax"])) < 6) {
      $tax_err = "Your tax number is incorrect!";
    } else {
      $tax = trim($_POST["tax"]);
    }
    
    // Validate namw
    if (empty(trim($_POST["name_organization"]))) {
      $name_organization_err = "Please enter your name organization!";
    } else {
      $name_organization = trim($_POST["name_organization"]);
    }

    // Validate email
    if (empty(trim($_POST["email"]))) {
      $email_err = "Please enter your email!";
    } else {
      $email = trim($_POST["email"]);
    }

    // Validate address
    if (empty(trim($_POST["address"]))) {
      $address_err = "Please enter your address!";
    } else {
      $address = trim($_POST["address"]);
    }

   

    // Check input errors before inserting in database
    if (empty($username_err) && empty($password_err) && empty($confirm_password_err)) {

      // Prepare an insert statement
      $sql = "INSERT INTO orrganization_profile (id, password, name_organization, tax, email, address) VALUES (?, ?, ?, ?, ?, ?)";

      if ($stmt = mysqli_prepare($link, $sql)) {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "sssssss", $param_username, $param_password, $name_organization, $tax, $email, $address);

        // Set parameters
        $param_username = $username;
        $param_password = password_hash($password, PASSWORD_DEFAULT); // Creates a password hash

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt)) {
          // Redirect to login page
          header("location: ../login/organization.php");
        } else {
          echo "Something went wrong. Please try again later.";
        }
      }

      // Close statement
      //mysqli_stmt_close($stmt);
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
  <title>Register</title>
  <style>
    span.password {
      float: right;
      padding-top: 16px;
    }

    .center-class {
      text-align: center;
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

    }
  </style>
</head>

<body>
  <div class="center-class">
  <h1>ORGANIZATION</h1>
  <h2>Register Form</h2>
  <button onclick="document.getElementById('dialog').style.display='block'" class="w3-button w3-blue">Register</button>
  </div>
  <div id="dialog" class="modal">
    <form class="modal-content animate" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
      <div class="w3-padding-large w3-row">
        <div class="w3-col s5 w3-margin">
          <div class="form-group <?php echo (!empty($username_err)) ? 'has-error' : ''; ?>">
            <label for="userName"><b>User Name</b></label>
            <input class="w3-input w3-padding-large" type="text" placeholder="Enter Username" name="username" value="<?php echo $username; ?>" required>
            <span class="w3-text-red"><?php echo $username_err; ?></span>
          </div>
          <div class="form-group <?php echo (!empty($name_organization_err)) ? 'has-error' : ''; ?>">
            <label for="name_organization"><b>Organization Name</b></label>
            <input class="w3-input w3-padding-large" type="text" placeholder="Enter your name" name="name_organization" value="<?php echo $name_organization; ?>" required>
            <span class="w3-text-red"><?php echo $name_organization_err; ?></span>
          </div>
          <div class="form-group <?php echo (!empty($tax_err)) ? 'has-error' : ''; ?>">
            <label for="phone"><b>Tax</b></label>
            <input class="w3-input w3-padding-large" type="text" placeholder="Enter your tax number" name="tax" value="<?php echo $tax; ?>">
            <span class="w3-text-red"><?php echo $tax_err; ?></span>
          </div>
          <div class="form-group <?php echo (!empty($email_err)) ? 'has-error' : ''; ?>">
            <label for="email"><b>Email</b></label>
            <input class="w3-input w3-padding-large" type="text" placeholder="Enter your email" name="email" value="<?php echo $email; ?>">
            <span class="w3-text-red"><?php echo $email_err; ?></span>
          </div>
        </div>
        <div class="w3-col s5 w3-margin">
          <div class="form-group <?php echo (!empty($address_err)) ? 'has-error' : ''; ?>">
            <label for="address"><b>Address</b></label>
            <input class="w3-input w3-padding-large" type="text" placeholder="Enter your address" name="address" value="<?php echo $address; ?>">
            <span class="w3-text-red"><?php echo $address_err; ?></span>
          </div>
          <div class="form-group <?php echo (!empty($password_err)) ? 'has-error' : ''; ?>">
            <label for="password"><b>Password</b></label>
            <input class="w3-input w3-padding-large" placeholder="Enter Password"  type="password" name="password" class="form-control" value="<?php echo $password; ?>" required>
            <span class="w3-text-red"><?php echo $password_err; ?></span>
          </div>
          <div class="form-group <?php echo (!empty($password_err)) ? 'has-error' : ''; ?>">
            <label for="password"><b>Confirm Password</b></label>
            <input class="w3-input w3-padding-large" placeholder="Enter Password"  type="password" name="confirm_password" value="<?php echo $confirm_password; ?>" required>
            <span class="w3-text-red"><?php echo $confirm_password_err; ?></span>
          </div>
        </div>
        <button type="submit" class="w3-button w3-blue w3-block">Register</button>
        <p class="center-class">Already have an account? <a href="../login/organization.php">Login here</a>.</p>
      </div>
      <div class="w3-padding center-class" style="background-color:#f1f1f1">
        <button type="reset" class="w3-btn w3-red center-class">Reset</button>
        <button type="button" onclick="document.getElementById('dialog').style.display='none'" class="w3-btn w3-blue-gray">Cancel</button>
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