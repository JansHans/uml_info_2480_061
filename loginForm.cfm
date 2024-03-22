<cfparam name="loginMessage" default=""/>

<cfoutput>

<div id="loginMessage">#loginMessage#</div>

<form action="#cgi.script_name#?p=login" method="post" >

    <div class="form-floating mb-3">    
        <input type="email" id="loginemail" name="loginemail" class="form-control" placeholder="Please enter your login email: "  required />
        <label for="loginemail">
            *Email: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please enter your login password: " required />
        <label for="loginpass">
            *Password: 
        </label>
    </div>

    <div>
        <input type="submit" class="btn btn-success" value="login" onclick="loginAccount()">Log In</button>
    </div>

</form>

</cfoutput>
