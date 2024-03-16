component {
    function obtainSearchResults(searchme){
        var qs = new query(datasource=application.dsource);
        qs.setSql("
            select * from books 
            inner join publishers on books.publisherid = publishers.id
            where title like :searchme");
        qs.addParam(name="searchme", value="%#searchme#%");
        return qs.execute().getResult();
    }  

}

