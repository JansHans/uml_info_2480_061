<cftry>
    
    <cfparam name="book" default="" />
    <cfparam name="qTerm" default="" />

    <cfset addEditFunctions = createObject("addedit") >
    <cfset addEditFunctions.processForms(form) >

    <div class="row">
        <div id="main" class="col-9">
            <cfif book.len() gt 0 >  
                <cfoutput>#mainForm()#</cfoutput>
            </cfif>
        </div>

        <div id="leftgutter" class="col-lg-3 order-first">
            <cfoutput>#sideNav()#</cfoutput>
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>
            #cfcatch#
        </cfoutput>
    </cfcatch>
</cftry>

<cffunction name="mainForm">

    <cfset var thisBookDetails=addEditFunctions.bookDetails(book) />
    <cfset var allPublishers = addEditFunctions.allPublishers() />
    <cfset var allGenres = addEditFunctions.allGenres() />
    <cfset var allGenresForThisBook = addEditFunctions.bookGenres(book) />

    <cfoutput>
        
        <h6>Fill out the form below to enter a new book:</h6>
        <form action="#cgi.script_name#?tool=addedit&book=#book#&qterm=#qterm#" method ="POST" enctype="multipart/form-data" >
        <div class="form-floating mb-3">    
            <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="Please enter the book's ISBN13" />
            <label for="isbn13">ISBN13: </label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Please enter the book's title"/>
            <label for="title">Book Title: </label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" id="weight" name="weight" step=".1" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Please enter the book's weight" />
            <label for="weight">Weight: </label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" id="year" name="year" step="1" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Please enter the Year Published" />
            <label for="year">Year: </label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" id="pages" name="pages" step="1" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Please enter the number of pages" />
            <label for="pages">Number of Pages: </label>
        </div>
        <div class="form-floating mb-3">
            <select class="form-select" id="publisherId" name="publisherId" aria-label="Publisher Select Control">
                <option ></option>
                    <cfloop query="allPublishers">
                        <option value="#id#" #id eq thisBookDetails.publisherId ? "selected" : ""# >#name#</option>
                    </cfloop>
            </select>
            <label for="publisher">Publisher: </label>
        </div>
       
        <div class="row">
            <div class="col">
                    <label for="uploadImage">Upload Cover</label>
                <div class="input-group mb-3">
                    <input type="file" id="uploadImage" name="uploadimage" class="form-control" />
                    <input type="hidden" name="image" value="#trim(thisBookDetails.image[1])#" />
                </div>
            </div>
        </div>
        <div class="col">
            <cfif thisBookDetails.image[1].len() gt 0 >
                <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px" />
            </cfif>
        </div>
        
        <div class="form-floating mb-3">
            <div>
                <label for="description">Description</label>
            </div>
                <textarea id="description" name="description">
                    <cfoutput>#thisBookDetails.description[1]#</cfoutput>
                </textarea>
                <script>
                    ClassicEditor
                        .create(document.querySelector("##description"))
                        .catch(error => {console.dir(error)});
                </script>
        </div>

        <div>
            <h6>Genres</h6>
            <cfloop query="allGenres">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="#id#" id="genre#id#" name="genre" >
                    <label class="form-check-label" for="genre#id#">
                      #name#
                    </label>
                </div>  
            </cfloop>
            <cfloop query = "allGenresForThisBook" >
                <script type="text/javascript">
                    document.getElementById("genre#genreId#").checked=true;
                </script>
            </cfloop>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%">Add Book</button>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="sideNav">
    <cfset var allBooks = addEditFunctions.sideNavBooks(qTerm) >    
    
    <cfoutput>

       #findBookForm()#
       <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=new">Click Here to Enter A New Book</a><hr>
            </li>
            <cfif qTerm.len() == 0>
                <!--- No Search Term Entered --->
            <cfelseif allBooks.recordcount == 0>
                No Results Found
            <cfelse>
            <cfloop query="allBooks">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?tool=addedit&book=#isbn13#&qTerm=#qTerm#" >#trim(title)#</a>
                </li>
            </cfloop>
        </cfif>
        
        </ul>
    </cfoutput>
</cffunction>

<cffunction name="findBookForm">
    <cfoutput>
        <br>
        <h5>Book Inventory</h5>
        <form action="#cgi.script_name#?tool=#tool#&book=#book#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory </label>
            </div>
        </form>
    </cfoutput>
</cffunction>

