<!--- The complex object struct, stateFunctions, is created in stateInfo.cfm below 
and contains the states of obtainUser, processNewAccount, and logMeIn  --->

<cfset stateFunctions = createObject("stateInfo") />

<!--- <cfdump var = "#session#" />
<cfset session.clear() /> --->

<!--- If there isn't a current session yet with the user, 
    then obtain the user information, put that in the database, 
    and create a user session named session.user --->

<cfif !session.keyExists("user")>
    <cfset session["user"] = stateFunctions.obtainUser() />
</cfif>


<!--- If the user has entered their first name into the create new account form,
then create an object for the new account named newAccountResult which will be processed --->

<cfif form.keyExists("firstname") >
    <cfset newAccountResult = stateFunctions.processNewAccount(form) />
    <cfset accountMessage = newAccountResult.message />

    <!--- the accountMessage above is used in newAccount.cfm --->
</cfif>

<cfif form.keyExists("loginpass")>
    <cfset userData = stateFunctions.logMeIn(form.loginemail, form.loginpass) />
        <cfif userData.recordCount == 1>
            <cfset session.user=stateFunctions.obtainUser(
                isLoggedIn=1,
                firstname=userData.firstname,
                lastname=userData.lastname,
                email=userData.email,
                isAdmin=userData.isAdmin
            ) />
            <cfset p="carousel">
            
        <cfelse>
            <cfset loginMessage="That login did not work." />
        </cfif>
</cfif>

<cfif url.keyExists("p") && url.p =='logoff'>
    <cfset session.user = stateFunctions.obtainUser() />
   <cfset p="carousel"/>
</cfif>
