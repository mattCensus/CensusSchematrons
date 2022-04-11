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
        <title>Alternate Title Check</title>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="count(gmd:alternateTitle) &gt; 0">NGDA datasets need an Alternate title</sch:assert>
            <sch:let name="altTest1" value="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]/gco:CharacterString[1]"/>
            <sch:assert test="contains($altTest1,'National Geospatial Data Asset')">The term 'National Geospatial Data Asset' must appear in the alertnate title.</sch:assert>
            <sch:assert test="contains($altTest1,'NGDA')">The term 'NGDA' must appear in the alertnate title.</sch:assert>
            <!-- see test if not true "-->
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <title>Keywords check</title>
        <rule  context="//gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]">
            <!--  -<sch:report test="count(gmd:MD_Keywords[1]/gmd:keyword[1]) != 3">There needs to be three keywords for the NGDA keywords</sch:report> -->
            <sch:assert test="count(gmd:MD_Keywords/gmd:keyword)  &gt; 2">There needs to be three keywords for the NGDA keywords</sch:assert> 
            <!-- first keyword -->
            <sch:assert test="string-length(gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]) = 4">This must contain 4 characters </sch:assert>
            <sch:let name="firstTest" value="substring(gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1],1,4)"/>
            <sch:assert test="contains($firstTest,'NGDA')">The first NGDA keyword should be 'NGDA" </sch:assert>
           <!-- second keyword -->
            <sch:let name="secondTest" value="substring(gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],1,12)"/>
           <!--  <sch:assert  test="string-length(gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1])&lt; 20" >This keyword must equal 'Governmental Units and Administrative and Statistical Boundaries Theme'
            or 'Transportation' (less than)</sch:assert>
            <sch:assert  test="string-length(gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1])&gt; 71" >This keyword must equal 'Governmental Units and Administrative and Statistical Boundaries Theme'
                or 'Transportation' (greater than)</sch:assert> -->
            <sch:assert test="contains($secondTest,'Governmental') or contains($secondTest,'Transportati')">This keyword must equal 'Governmental Units and Administrative and Statistical Boundaries Theme'
                or 'Transportation' (word test)</sch:assert>
            <sch:assert test="contains(gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'Theme')">This keyword must equal 'Governmental Units and Administrative and Statistical Boundaries Theme'
                or 'Transportation Theme' (The word "Theme" is missing)</sch:assert>
            <!-- Third Keyword National Geospatial Data Asset-->
            <sch:assert test="string-length(gmd:MD_Keywords[1]/gmd:keyword[3]/gco:CharacterString[1]) = 30">This must contain 30 characters </sch:assert>
            <sch:let name="thirdTest" value="substring(gmd:MD_Keywords[1]/gmd:keyword[3]/gco:CharacterString[1],1,30)"/>
            <sch:let name="thirdTestA" value="substring(gmd:MD_Keywords[1]/gmd:keyword[3]/gco:CharacterString[1],1,8)"/>
            <sch:let name="thirdTestB" value="substring(gmd:MD_Keywords[1]/gmd:keyword[3]/gco:CharacterString[1],26,5)"/>
            <sch:assert test="contains($thirdTest,'National')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'National'</sch:assert>
            <sch:assert test="contains($thirdTest,'Geospatial')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'Geospatial'</sch:assert>
            <sch:assert test="contains($thirdTest,'Data')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'Data'</sch:assert>
            <sch:assert test="contains($thirdTest,'Asset')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'Asset'</sch:assert>
            <sch:assert test="contains($thirdTestA,'National')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'National'. It has to be the
                                                                first word.</sch:assert>
            <sch:assert test="contains($thirdTestB,'Asset')">The third keyword should be 'National Geospatial Data Asset'. You are missing 'Asset'.  It has to be the last word.</sch:assert>
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
    
    <sch:pattern>
        <title>WMS Check</title>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[3]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]"> 
      
        <!-- counting to make sure all the components are there -->
            <assert test="count(gmd:linkage[1]/gmd:URL[1]) &gt; 0">There msut a URL for the Web Mapping Service (WMS).</assert>
            <assert test="count(gmd:applicationProfile[1]/gco:CharacterString[1])  &gt; 0"> There must be an application profile for the Web Mapping Service (WMS).</assert>
            <assert test="count(gmd:name[1]/gco:CharacterString[1])&gt; 0">There must be a name for the Web Mapping Service (WMS).</assert>
            <assert test="count(gmd:description[1]/gco:CharacterString[1]) &gt; 0">There must be a description of the for the Web Mapping Service (WMS).</assert>
            <assert test="count(gmd:function[1]/gmd:CI_OnLineFunctionCode[1])&gt; 0" >There must be a function code for the Web Mapping Service (WMS).</assert>
            <!-- verifying the linkage https://tigerweb.geo.census.gov/arcgis/services/TIGERweb-->
            <assert test="contains(gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/services/TIGERweb')"> The linkage must contain
                'https://tigerweb.geo.census.gov/arcgis/services/TIGERweb' and the name of the WMS. </assert>
            <assert test="contains(gmd:applicationProfile[1]/gco:CharacterString[1],'http://opengis.net/spec/wms')"> The application profile must be 'http://opengis.net/spec/wms'.</assert>
            <!-- checking the function -->
            <!-- Checking the function code list-->
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeList)= 86">The codelist attribute must be 86 characters</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeList,'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnlineFunctionCode')">
                The codelist attribute must contains 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnlineFunctionCode'
            </assert>
            <!-- Check the codelistvalue -->
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue)=8">The codelist value must be 8 characters</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download')"> The value for the function code must be 'download'</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1],'download')"> The value for the function code must be 'download'</assert>
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1])=8">The codelist value must be 8 characters</assert>
        </sch:rule>
    </sch:pattern>
    
    <pattern>
       <title>Rest Check</title>
        <rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            
            <!-- counting to make sure all the components are there -->
            <assert test="count(gmd:linkage[1]/gmd:URL[1]) &gt; 0">There msut a URL for the REST Service.</assert> 
            <assert test="count(gmd:applicationProfile[1]/gco:CharacterString[1])  &gt; 0"> There must be an application profile for the REST.</assert>
            <assert test="count(gmd:name[1]/gco:CharacterString[1])&gt; 0">There must be a name for the REST.</assert>
            <assert test="count(gmd:description[1]/gco:CharacterString[1]) &gt; 0">There must be a description of the for the REST.</assert>
            <assert test="count(gmd:function[1]/gmd:CI_OnLineFunctionCode[1])&gt; 0" >There must be a function code for the REST.</assert>
            <!-- verifying the linkage https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb-->
            <assert test="contains(gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb')"> The linkage must contain
                'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb' and the name of the REST Service. </assert>
            <!-- verifying the application profile http://www.geoplatform.gov/spec/esri-map-rest-->
            <assert test="string-length(gmd:applicationProfile[1]/gco:CharacterString[1]) =45"> The application profile must be 45 characters.
                It must be 'http://www.geoplatform.gov/spec/esri-map-rest' and have no spaces.</assert>
            <assert test="contains(gmd:applicationProfile[1]/gco:CharacterString[1],'http://www.geoplatform.gov/spec/esri-map-rest')"> The application profile must be 'http://www.geoplatform.gov/spec/esri-map-rest'.</assert>
           <!-- checking the function -->
            <!-- Checking the function code list-->
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeList)= 86">The codelist attribute must be 86 characters</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeList,'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnlineFunctionCode')">
                The codelist attribute must contains 'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnlineFunctionCode'
            </assert>
            <!-- Check the codelistvalue -->
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue)=8">The codelist value must be 8 characters</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download')"> The value for the function code must be 'download'</assert>
            <assert test="contains(gmd:function[1]/gmd:CI_OnLineFunctionCode[1],'download')"> The value for the function code must be 'download'</assert>
            <assert test="string-length(gmd:function[1]/gmd:CI_OnLineFunctionCode[1])=8">The codelist value must be 8 characters</assert>
        </rule>
    </pattern>
   
</schema>
