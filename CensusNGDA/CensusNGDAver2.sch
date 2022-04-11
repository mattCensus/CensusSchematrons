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
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="count(gmd:alternateTitle) &gt; 0">NGDA datasets need an Alternate
                title</sch:assert>
            <!-- see test if not true "-->
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <rule  context="//gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]">
            <!--  -<sch:report test="count(gmd:MD_Keywords[1]/gmd:keyword[1]) != 3">There needs to be three keywords for the NGDA keywords</sch:report> -->
            <sch:assert test="count(gmd:MD_Keywords/gmd:keyword)  &gt; 2">There needs to be three keywords for the NGDA keywords</sch:assert> 
            <sch:assert test="string-length(gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]) = 4">This must contain 4 characters </sch:assert>
            <sch:let name="firstTest" value="substring(gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1],1,4)"/>
            <sch:assert test="contains($firstTest,'NGDA')">The first NGDA keyword should be 'NGDA" </sch:assert>
            <!--  <sch:report test="contains(/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1],'NGDA')" >The first keyword must 'NGDA'</sch:report>
            <sch:assert test="substring(/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1],1,4)='NGDA'">The first keyword must 'NGDA'</sch:assert>-->
        </rule>
    </sch:pattern>

    <!--  <sch:pattern>
        <rule context="//gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]">
            <sch:assert test="contains(/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1],'NGDA')">The first keyword must be 'NGDA'</sch:assert>
        </rule>
    </sch:pattern>-->

    <pattern>
        <title>EX_GeographicBoundingBox</title>
        <rule context="//gmd:EX_GeographicBoundingBox">      
            <assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">West Bounding Longitude must be -180 or greater</assert>
            <assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">West Bounding Longitude must be 180 or less</assert>
            <assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">eastBoundLongitude must be -180 or greater</assert>
            <assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">eastBoundLongitude must be -180 or greater</assert>
            <assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">southBoundLatitude must be -90 or greater</assert>
            <assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">southBoundLatitude must be 90 or less</assert>
            <assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">northBoundLatitude must be -90 or greater</assert>
            <assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">northBoundLatitude must be 90 or less</assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </rule>
    </pattern>
    
    <pattern>
        <title>//gmd:MD_DataIdentification</title>
        <rule context="//gmd:MD_DataIdentification">
            <report test="(not(../../gmd:hierarchyLevel) or (../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue = 'dataset') or (../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue = 'series')) and (not(gmd:topicCategory))">
                If the metadata gmd:hierarchyLevel code = 'dataset' or 'series' then gmd:topicCategory is mandatory.</report><!-- see test if true -->

        </rule>
    </pattern>
</schema>
