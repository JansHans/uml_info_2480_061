<cfparam name="accountMessage" default="" />

<script type="text/javascript">
    function validateNewAccount(){
        let originalPassword = document.getElementById("password").value;
        let confirmPassword = document.getElementById("confirmPassword").value;
        
        if(originalPassword.length && originalPassword === confirmPassword){
            console.dir("submit the form")
        } else {
            document.getElementById("accountMessage").innerHTML = "Please check that you entered the password.";
            console.dir("It didn't work");
        }
        
        console.dir(originalPassword);
        console.dir(confirmPassword);
    }
</script>
<cfoutput>
<div id="accountMessage">#accountMessage#</div>
</cfoutput>
<form action="#cgi.script_name#?p=login" method="post" >
    <div class="form-floating mb-3">    
        <input type="text" id="title" name="title" class="form-control" placeholder="Please enter your title (Mr., Ms., Mrs., Miss, etc.): " />
        <label for="title">
            Title: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="text" id="firstname" name="firstname" class="form-control" placeholder="Please enter your first name: " required />
        <label for="firstname">
            *First Name:  
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="text" id="lastname" name="lastname" class="form-control" placeholder="Please enter your last name: " required />
        <label for="lastname">
            *Last Name: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="email" id="email" name="email" class="form-control" placeholder="Please enter your email: "  required />
        <label for="email">
            *Email: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="password" id="password" name="password" class="form-control" placeholder="Please enter a password: " required />
        <label for="password">
            *Password: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Please confirm your password: " required />
        <label for="confirmPassword">
            *Confirm Password: 
        </label>
    </div>

    <div>
        <button type="button" class="btn btn-warning" onclick="validateNewAccount()">Make New Account</button>
    </div>


</form>

