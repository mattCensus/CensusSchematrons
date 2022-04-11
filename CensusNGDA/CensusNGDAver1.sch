<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
         xmlns:geonet="http://www.fao.org/geonetwork"
         xmlns:iso="http://purl.oclc.org/dsdl/schematron"
         schemaVersion="ISO19757-3" queryBinding="xslt2"
         xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    
  
    <ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <ns prefix="gts" uri="http://www.isotc211.org/2005/gts"/>
    <ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi"/>
    <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="count(gmd:alternateTitle)&gt;0">NGDA datasets need an Alternate title</sch:assert><!-- see test if not true "-->
        </sch:rule>
    </sch:pattern>
   
    <sch:pattern>
         <rule context="//gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]">
             <sch:report test="count(//gmd:MD_Keywords[1]/gmd:keyword[1])!=3">There needs to be three keywords for the NGDA keywords</sch:report>
         </rule>
    </sch:pattern>
    
    <pattern>
        <title>//gmd:MD_DataIdentification</title>
        <rule context="//gmd:MD_DataIdentification">
            <report test="(not(../../gmd:hierarchyLevel) or (../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset') or (../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='series')) and (not(gmd:topicCategory))">If the metadata gmd:hierarchyLevel code = 'dataset' or 'series' then gmd:topicCategory is mandatory.</report>
        </rule>
    </pattern>
</schema>  