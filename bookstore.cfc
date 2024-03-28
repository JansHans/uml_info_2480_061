component {
    function obtainSearchResults( searchme, genre){
        if(searchme.len()){
        var qs = new query(datasource=application.dsource);
        qs.setSql("
            SELECT * FROM books 
            INNER JOIN publishers ON books.publisherid = publishers.id
            WHERE title LIKE :searchme OR isbn13=:isbn13");
        qs.addParam(name="searchme", value="%#searchme#%");
        qs.addParam(name="isbn13", value="#searchme#");
        return qs.execute().getResult();
        } else if (genre.len()){
            var qs = new query(datasource=application.dsource);
            qs.setSql("select * from books inner join genreToBook 
            on books.isbn13 = genreToBook.bookId
            where genreToBook.genreId = :genreId")
            qs.addParam(name="genreId", value=arguments.genre)
            return qs.execute().getResult();
        }
    } 

    function genresInStock(){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select distinct name, genreId from genreToBook
            inner join genres on genreToBook.genreId = genres.id
            order by genres.name
            ");

        return qs.execute().getResult();
    }

}



