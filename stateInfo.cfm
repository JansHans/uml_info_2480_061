<cfset stateFunctions = createObject("stateInfo") />
<cfset session.clear() />
<cfif !session.keyExists("user")>
    <cfset session["user"] = stateFunctions.obtainUser() />
</cfif>