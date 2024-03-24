component {
    function obtainSearchResults(required string searchme){
        var qs = new query(datasource=application.dsource);
        qs.setSql("
            SELECT * FROM books 
            INNER JOIN publishers ON books.publisherid = publishers.id
            WHERE title LIKE :searchme OR isbn13=:isbn13");
        qs.addParam(name="searchme", value="%#searchme#%");
        qs.addParam(name="isbn13", value="#searchme#");
        return qs.execute().getResult();
    } 

}



