component {
    function obtainSearchResults(searchme){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from books where title like :searchme");
        qs.addParam(name="searchme", value="%#searchme#%");
        return qs.execute().getResult();
    }  

}

