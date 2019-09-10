<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:geonet="http://www.fao.org/geonetwork"
    xmlns:iso="http://purl.oclc.org/dsdl/schematron" schemaVersion="ISO19757-3" queryBinding="xslt2"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    
    
    <ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <ns prefix="gts" uri="http://www.isotc211.org/2005/gts"/>
    <ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi"/>
    <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
    
    <!-- For GPM validation -->
    <pattern>
        <title>Title Check</title>
        <rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <assert test="contains(.,'Partnership')">All file titles must contain Partnership</assert>
        </rule>
    </pattern>
    
    <pattern>
        <title>Metadata Date Check</title>
        <rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Date[1]">
            <assert test="contains(.,'2019')">The metadata date does not contain the correct year!!! </assert>
        </rule>
    </pattern>
    
   <!-- go up one higher to check the date -->
    <!-- ./Detailed_Description[1]/Entity_Type[1]/Entity_Type_Label[1] -->
    <pattern>
        <title>Feature Catalogue Description</title>
        <rule context="/GPM/Entity_and_Attribute_Information">
            <assert test="contains(./Detailed_Description[1]/Entity_Type[1]/Entity_Type_Label[1],'.shp')"></assert>
            <assert test="count(./Feature_Catalogue_Description) =1">There needs to be a Feature Catalogue Description</assert>
            <assert test="contains(./Feature_Catalogue_Description/FC_Title,'Partnership')">The Feature Catalogue Description must contain Partnership></assert>
            <assert test="contains(./Feature_Catalogue_Description/FC_Title,'Feature Catalog')">The Feature Catalogue Description must contain Feature Catalog</assert>
        </rule>
    </pattern>
    
    <!--   <report test="contains(./FC_Title,'Partnership')">The Feature Catalogue Description must contain Partnership</report>
            <report test="contains(./FC_Title,'Feature Catalog')">The Feature Catalogue Description must contain Feature Catalog</report > -->
</schema>