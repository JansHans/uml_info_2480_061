<cfparam name="loginMessage" default=""/>

<cfoutput>

<div id="loginMessage">#loginMessage#</div>

<form action="#cgi.script_name#?p=login" method="post" >

    <div class="form-floating mb-3">    
        <input type="email" id="loginemail" name="loginemail" class="form-control" placeholder="Please enter your user name: "  required />
        <label for="loginemail">
            *Email: 
        </label>
    </div>

    <div class="form-floating mb-3">    
        <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please enter your password: " required />
        <label for="loginpass">
            *Password: 
        </label>
    </div>

    <div class="form-floating mb-3">
        <input type="submit" class="btn btn-primary" value="login" style="width: 100%">
    </div>

</form>

</cfoutput>
