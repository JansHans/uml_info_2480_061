component {
   
    function processForms( required struct formData ){
        // writeDump (formData);
        if (formData.keyExists( "isbn13" ) && formData.keyExists("title") && formData.title.len() > 0) {
        
            if (formData.keyExists( "uploadImage" ) && formData.uploadImage.len()) {
                arguments.formData.image = uploadBookCover();
            }

        var qs = new query( datasource = application.dsource );
        qs.setSql( "
            IF NOT EXISTS( SELECT * FROM books WHERE isbn13=:isbn13)
                INSERT INTO books (isbn13,title) VALUES (:isbn13,:title);
        
            UPDATE books SET
                title=:title,
                weight=:weight,
                year=:year,
                pages=:pages,
                publisherId=:publisherId,
                image=:image,
                description=:description
            WHERE isbn13=:isbn13
            " );
        qs.addParam(
            name      = "isbn13",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.isbn13),
            null      = formData.isbn13.len() != 13 
        );
        qs.addParam(
            name      = "title",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.title),
            null      = formData.title.len()==0
        );
        qs.addParam(
            name      = "weight",
            cfsqltype = "CF_SQL_DECIMAL",
            value     = trim(formData.weight),
            null      = !isValid("numeric", formData.weight)
        );
        qs.addParam(
            name      = "year",
            cfsqltype = "CF_SQL_INTEGER",
            value     = trim(formData.year),
            null      = !isValid("numeric", formData.year)
        );
        qs.addParam(
            name      = "pages",
            cfsqltype = "CF_SQL_INTEGER",
            value     = trim(formData.pages),
            null      = !isValid("numeric", formData.pages)
        );
        qs.addParam(
            name      = "publisherId",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.publisherId),
            null      = trim(formData.publisherId).len() != 35
         );
         qs.addParam(
            name      = "image",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.image),
            null      = trim(formData.image).len() == 0
         );
         qs.addParam(
            name      = "description",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = trim(formData.description),
            null      = trim(formData.description).len() == 0
         );
        qs.execute();

        // finish
        // if(formData.keyExists("genre")){

        //     deleteAllBookGenres(formData)

        //     formData.genre.listToArray().each( function(item){
        //         insertGenre(item, formData.isbn13)
        //     }
        // }


        }
    }

    function sideNavBooks(qTerm){
        if(qTerm.len() == 0) {
            return queryNew("title");
        } else {
            var qs = new query(datasource=application.dsource);
            qs.setSql("select * from books where title like :qterm order by title");
            qs.addParam(name="qTerm", value="%#qterm#%");
            return qs.execute().getResult();
        }
    }

    function bookDetails(isbn13){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from books where isbn13=:isbn13");
        qs.addParam(
            name      = "isbn13",
            cfsqltype = "CF_SQL_NVARCHAR",
            value     = arguments.isbn13);
        return qs.execute().getResult();
    }

    function allPublishers(isbn13){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from publishers order by name");
        return qs.execute().getResult();
    }

    function uploadBookCover(){
        var imageData = fileUpload(
            expandPath("../images/"),
            "uploadImage",
            "*",
            "makeUnique"
            );
            writeDump(imageData);
            return imageData.serverFile;
    }

    function allGenres(isbn13){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from genres order by name");
        return qs.execute().getResult();
    }

    // finish
    // accepts the genreid and the BookId (isbn13) and inserts them
   // in the genreToBooks Table
    // function insertGenre(genreId, bookId){
    //     var qs = new query(datasource=application.dsource);
    //     qs.setSql("insert into genresToBook(bookid, genreid) VALUES (:bookid, :genreid) ");
    //     qs.addParam(name="bookid", value=argument.bookId);
    //     qs.addParam(name="genreid", value=argument.genreId);
    // }
    // // finish
    // function deleteAllBookGenres(bookId){
    //     var qs = new query(datasource=application.dsource);
    //     qs.setSql("delete from genresToBook WHERE bookid=:bookid");
    //     qs.addParam(name="bookid", value=argument.bookId);
    //     qs.addParam(name="genreid", value=argument.genreId);
    // }
}
