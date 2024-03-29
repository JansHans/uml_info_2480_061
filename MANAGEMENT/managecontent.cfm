<cftry>
    
    <cfparam name="content" default="" />
    <cfparam name="qTerm" default="" /> 

    <cfset addEditContentFunctions = createObject("managecontent") >
    <cfset addEditContentFunctions.processForms(form) >

    <div class="row">
        <div id="main" class="col-9">
            <cfif content.len() gt 0 >  
                <cfoutput>#mainContentForm()#</cfoutput>
            </cfif>
        </div>

        <div id="leftgutter" class="col-lg-3 order-first">
            <cfoutput>#sideContentNav()#</cfoutput>
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>
            #cfcatch#
        </cfoutput>
    </cfcatch>
</cftry>

<cffunction name="mainContentForm">

    <cfset var thisContentDetails=addEditContentFunctions.contentDetails(content) />
    
    <cfset var allContents = addEditContentFunctions.allContents() />
    <cfset var allContentsForContent = addEditContentFunctions.contentContents(content) />

    <cfoutput>
        
        <h6>Fill out the form below to enter a new content article:</h6>
        <form action="#cgi.script_name#?tool=managecontent&content=#content#&qterm=#qterm#" method ="POST" enctype="multipart/form-data" >
        <div class="form-floating mb-3">    
            <input type="text" id="id" name="id" class="form-control" value="#thisContentDetails.id[1]#" placeholder="Please enter a new UUID" />
            <label for="id">New UUID: </label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" id="title" name="title" class="form-control" value="#thisContentDetails.title[1]#" placeholder="Please enter the new content article's title"/>
            <label for="title">Content Article Title: </label>
        </div>
       
        <div class="form-floating mb-3">
            <div>
                <label for="description">Content: </label>
            </div>
                <textarea id="description" name="description">
                    <cfoutput>#thisContentDetails.description[1]#</cfoutput>
                </textarea>
                <script>
                    ClassicEditor
                        .create(document.querySelector("##description"))
                        .catch(error => {console.dir(error)});
                </script>
        </div>

        <div>
            <h6>Content Titles</h6>
            <cfloop query="allContents">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="#id#" id="content#id#" name="content" >
                    <label class="form-check-label" for="content#id#">
                      #title#
                    </label>
                </div>  
            </cfloop>
            <cfloop query = "allContentsForContent" >
                <script type="text/javascript">
                    document.getElementById("content#id#").checked=true;
                </script>
            </cfloop>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%">Add Content</button>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="sideContentNav">
    <cfset var allContents = addEditContentFunctions.sideContentNav(qTerm) >    
    
    <cfoutput>

       #findContentForm()#
       <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?tool=managecontent&content=new">Click Here to Enter A New Content Article</a><hr>
            </li>
            <cfif qTerm.len() == 0>
                <!--- No Search Term Entered --->
            <cfelseif allContents.recordcount == 0>
                No Results Found
            <cfelse>
            <cfloop query="allContents">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?tool=managecontent&content=#id#&qTerm=#qTerm#" >#trim(title)#</a>
                </li>
            </cfloop>
        </cfif>
        
        </ul>
    </cfoutput>
</cffunction>

<cffunction name="findContentForm">
    <cfoutput>
        <br>
        <h5>Available Content for Editing: </h5>
        <form action="#cgi.script_name#?tool=#tool#&content=#content#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find content to edit" />
                <label for="qterm">Search Available Content to Edit</label>
            </div>
        </form>
    </cfoutput>
</cffunction>

