<cfdump var="#form#">

<cfparam name="searchme" default=""/>

<cfoutput>
    <cfset bookInfo = bookstoreFunctions.obtainSearchResults( searchme )/>

    <cfif bookinfo.recordcount == 0>
       #noResults()# 
    <cfelseif bookinfo.recordcount == 1>
        #oneResult()# 
    <cfelse>
         #manyResults()#    
    </cfif>

</cfoutput>

<cffunction name="noResults">
    <h6>There were no results found. Please try again.</h6>
</cffunction>

<cffunction name="oneResult">
    <div class="row">
        <div class="col-6">
            <cfoutput>
                <img src="images/#bookinfo.image[1]#" style = "float:left; width:250px; height:250px" />
                <span>Title: #bookinfo.title[1]#</span>
                <span>Publisher: #bookinfo.name[1]#</span>
            </cfoutput>
        </div>
    </div><br>
    <h6>There was one result found.</h6>
</cffunction>

<cffunction name="manyResults">
    <h6>Your results are below:</h6><br>
    
    <cfoutput>
        <div>
            <div>
              <ol class="nav flex-column">
                <cfoutput query="bookinfo">
                    <li class="nave-item">
                        <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">
                            #trim(title)#
                        </a>
                    </li>
                </cfoutput>
              </ol>  
            </div>

        </div>
    </cfoutput>
    
</cffunction>