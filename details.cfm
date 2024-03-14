<cfparam name="searchMe" default=""/>

<cfoutput>
    <cfset bookinfo = bookstoreFunctions.obstainSearchResults( searchme )/>
    
    There are #bookinfo.recordcount# books in it.

    <cfif bookinfo.recordcount == 0>
        There were no Results. Please search again.
    <cfelseif bookinfo.recordcount == 1>
        <cfset oneResult()/>
        
    <cfelse>
        There were many Books
    </cfif>

    <cfdump var="#bookinfo#"
</cfoutput>

<cffunction name="oneResult">
    <div class="row">
        <div class="col-6">
            <img src="images/#bookinfo.image[1]#" "style = width:100px">
        </div>
    </div>
    There was 1 book in the result. Hi I'm in a function.
</cffunction>

<cffunction name="manyResults">
    <cfoutput>
        <div>
            <div></div>

        </div>
    </cfoutput>
    There were many books. I'm in a function as well.
</cffunction>