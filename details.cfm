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
    "There were no results found. Please try again."
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
    </div>
    "There was one result found."
</cffunction>

<cffunction name="manyResults">
    <cfoutput>
        <div>
            <div>
              <ol class="nav flex-column">
                <cfoutput query="bookinfo">
                    <li class="nave-item">
                        <a class="nav-link" href="#cgi.script_name#?
                        =details&searchme=#trim(isbn13)#">
                            #trim(title)#
                        </a>
                    </li>
                </cfoutput>
              </ol>  
            </div>

        </div>
    </cfoutput>
    "There were more than one result."
</cffunction>