<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">ISO_NGDACounties.sch #1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="metadataDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date">
            <sch:let name="yearA" value="."/>
            <sch:assert test="$yearA = '2020'" >ISO_NGDACounties.sch err#2: The year must be 2020. It is currently:    <sch:value-of select="$yearA"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="CodeIdentifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <sch:assert test="count(./gmd:identifier)=1">ISO_NGDACounties.sch err#3: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="identifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:identifier[1]/gmd:MD_Identifier[1]/gmd:code[1]/gco:CharacterString">
            <sch:assert test="count(.)=1">ISO_NGDACounties.sch err#4: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="RootElementsCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]">
            <sch:assert test="count(.)=1">ISO_NGDACounties.sch err#5: The fileIdentifier is missing. </sch:assert>
            <sch:assert test="string-length(.)>15">ISO_NGDACounties.sch err#6: The filename is to short. Make sure the complete filename is there</sch:assert>
            <sch:assert test="contains(.,'.shp.iso.xml')">ISO_NGDACounties.sch err#7: The filename must contain .shp.iso.xml </sch:assert>
            <sch:assert test="contains(.,'tl_2020')">ISO_NGDACounties.sch err#8 The filename must contain 'tl_2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <!--  /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]
   /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]
  /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]
   
   -->
    <sch:pattern id="ISO3166CheckStates">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]/gmd:MD_Keywords[1]">
            <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> 
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:let name="PlaceThes" value="string-length(.)"/>
            <sch:assert test="matches(normalize-space(.),'38-2009')">ISO_NGDACounties.sch err#9: The value for the thesauraus should be 'National Standard Codes (ANSI INCITS 38-2009), Federal Information Processing Series (FIPS) – States/State Equivalents' </sch:assert>
            <sch:assert test="$PlaceThes  &lt; 529">ISO_NGDACounties.sch err#10: Make Sure the value for the Place Thesaurus is correct <sch:value-of select="$PlaceThes"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_NGDACounties.sch err#11: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">ISO_NGDACounties.sch err#12: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the download file .-->
    <sch:pattern id="URLDownloadCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(gmd:linkage)=1">ISO_NGDACounties.sch err#24: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">ISO_NGDACounties.sch err#25: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">ISO_NGDACounties.sch err#26: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">ISO_NGDACounties.sch err#27: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">ISO_NGDACounties.sch err#28: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_NGDACounties.sch err#29: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">ISO_NGDACounties.sch err#30: The download file for the download URL must contain '.zip'</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2021')">ISO_NGDACounties.sch err#31: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2021'</sch:assert>
            
            <!--  <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER/')">NGDAChecksForSeriesInfoFiles_States.sch err#19: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER'</sch:assert>
            -->
            <sch:report test="contains(./gmd:description[1],'C:/Users')">ISO_NGDACounties.sch err#32: This should not contain "C:/Users" </sch:report>
            
            <sch:let name="descriptionLength" value="string-length(./gmd:description[1]/gco:CharacterString[1])"/>
            <sch:report test="$descriptionLength>1">ISO_NGDACounties.sch err#33: The string lenght is  <sch:value-of select="$descriptionLength"/></sch:report>
            <sch:report test="contains(./gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download!!')">ISO_NGDACounties.sch err#34:  This attribute should not contain !!!</sch:report>
            <sch:report test="contains(./gmd:description[1],'\tl')">ISO_NGDACounties.sch err#35:  This attribute should not contain \</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EATitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">ISO_NGDACounties.sch #36: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">ISO_NGDACounties.sch #37: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">ISO_NGDACounties.sch #38: The file name must contain '2020'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">ISO_NGDACounties.sch #39: The title should include "Shapefile'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAOtherCitationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
            <sch:let name="TLYear" value="string(contains(.,'tl_2021'))"/> 
            <sch:let name="TLDir" value="string(contains(.,'Current_19110'))"></sch:let>
            <sch:assert test="$TLYear='true'">ISO_NGDACounties.sch #40: The URL must contain 'tl_2021'.</sch:assert>
            <sch:assert test="$TLDir='true'">ISO_NGDACounties.sch #41: The directory must be 'Current_19110'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">ISO_NGDACounties.sch #42: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_NGDACounties.sch #43: The title name must contain 'Current'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:edition[1]">
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:assert test="$Year='true'">ISO_NGDACounties.sch #44: The edition name must contain '2021'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:extent[1]/gmd:EX_Extent[1]">
            <sch:assert test="count(./gmd:geographicElement)=1">ISO_NGDACounties.sch #45: The bounding coordinates are missing</sch:assert>
            <sch:assert test="count(./gmd:temporalElement)=1">ISO_NGDACounties.sch #46: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2020'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2021'))"/> 
            <sch:assert test="$beginYear='true'">ISO_NGDACounties.sch #47: The beginning year must be '2020'</sch:assert>
            <sch:assert test="$endYear='true'">ISO_NGDACounties.sch #48: The ending year must be '2021'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBoxCheck'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">ISO_NGDACounties.sch #49: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">ISO_NGDACounties.sch #50: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_NGDACounties.sch #51: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_NGDACounties.sch #52: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">ISO_NGDACounties.sch #53: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">ISO_NGDACounties.sch #54:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">ISO_NGDACounties.sch #55: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">ISO_NGDACounties.sch #56:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ='otherRestrictionCheck'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//gmd:MD_LegalConstraints">
            <sch:report test="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_NGDACounties.sch #57: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_NGDACounties.sch #58: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='MdDistributionCheck'>
        <sch:title>gmd:MD_Distribution</sch:title>
        <sch:rule context="//gmd:MD_Distribution">
            <sch:assert test="count(gmd:distributionFormat)&gt;0 or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)&gt;0">ISO_NGDACounties.sch #59: You must provide either gmd:distributionFormat or gmd:distributorFormat.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="datasourcecheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]">
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2020'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2021'))"/> 
            <sch:assert test="$beginYear='true'">ISO_NGDACounties.sch #60: The beginning year must be '2020'</sch:assert>
            <sch:assert test="$endYear='true'">ISO_NGDACounties.sch #61: The ending year must be '2021'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">ISO_NGDACounties.sch #62: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:hierarchyLevel[1]/gmd:MD_ScopeCode[1]/@codeListValue">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='dataset'">ISO_NGDACounties.sch #63: The hierarchy level must be 'dataset' </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetBoundingBoxCheck'>
        <sch:title>gmd:MD_DataIdentification Extent</sch:title>
        <sch:rule context="//gmd:MD_DataIdentification">
            <sch:report test="(not(gmd:hierarchyLevel) or gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset') and (count(//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox) + count (//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicDescription)) =0">
                ISO_NGDACounties.sch #64: If the metadata gmd:hierarchyLevel code = 'dataset' then you must document gmd:EX_GeographicBoundingBox or gmd:EX_GeographicDescription.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString[1] -->
    
    <sch:pattern id='datasetURICheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:dataSetURI[1]">
            <sch:assert  test="contains(.,'https')">ISO_NGDACounties.sch #65: The URL should contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetURICheck2'>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString">
            <!-- Change the assert expression. -->
            <sch:assert test="starts-with(.,'https:')">ISO_NGDACounties.sch #66: The URL must contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>



<sch:pattern id='downloadcheck'>
    <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
            ISO_NGDACounties.sch #67: The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">
            ISO_NGDACounties.sch #68: The download file should contain 'https'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain 'https'
            </sch:assert>-->
        <sch:assert test="count(gmd:linkage)=1"> ISO_NGDACounties.sch #69: The linkage URL is missing.</sch:assert>
        <sch:assert test="count(gmd:applicationProfile)=1"> ISO_NGDACounties.sch #70: The gmd:applicationProfile element is missing. </sch:assert>
        <sch:assert test="count(gmd:name)=1"> ISO_NGDACounties.sch #71: The gmd:name element is missing. </sch:assert>
        <sch:assert test="count(gmd:description)=1"> ISO_NGDACounties.sch #72: The gmd:description element is missing.</sch:assert>
        <sch:assert test="count(gmd:function)=1"> ISO_NGDACounties.sch #73: The gmd:function element is missing.</sch:assert>
    </sch:rule>
</sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile') or contains(.,'Relationship File'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">ISO_NGDACounties.sch #74: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">ISO_NGDACounties.sch #75: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">ISO_NGDACounties.sch #76: The file name must contain '2021'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">ISO_NGDACounties.sch #77: The title should include "Shapefile' or 'Relationship File'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4] -->
    <sch:pattern id='keywordsCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:let name="KeywordCount" value="count(gmd:descriptiveKeywords)"></sch:let>
            <sch:assert test="count(gmd:descriptiveKeywords)=5"> ISO_NGDACounties.sch #78:Make sure there are five sets of keywords, There are currently <sch:value-of select="$KeywordCount"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4] -->
    <sch:pattern id="countyCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'31-2009'))"/>
            <sch:assert test="$countyFips='true'">ISO_NGDACounties.sch #79: The second set of keyword must contain 'ANSI INCITS 31-2009' for the value of the thesaurus. It must have county values </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4] -->
    <sch:pattern id="stateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'38-2009'))"/>
            <sch:assert test="$countyFips='true'">ISO_NGDACounties.sch #80: The second set of counties must contain 'ANSI INCITS 38-2009' for the value of the thesaurus. It must have state values.</sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[5] -->
    <sch:pattern id="nationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[5]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'3166'))"/>
            <sch:assert test="$countyFips='true'">ISO_NGDACounties.sch #81: The second set of counties must contain '38-2009' for the value of the thesaurus. It must have national values </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- NGDA Checks -->
    
    <sch:pattern id="altTitleCount">
        <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
            <sch:assert test="count(gmd:alternateTitle)=2">ISO_NGDACounties.sch err#82: At least one alternate title is missing</sch:assert>
            <sch:let name="altTitle" value="/gmd:alternateTitle/gco:CharacterString"/>
            <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
            <!--   <sch:assert test="starts-with($altTitleA,'National')">The phrase "National Geospatial Data Asset" is missing from the beginning
             of the alternate title </sch:assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck1">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]">
            <sch:assert test="matches(normalize-space(.),'TIGER/Line Shapefile')">ISO_NGDACounties.sch err#83: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(.),'2021')">ISO_NGDACounties.sch err#84:tHE YEAR MUST BE '2021'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[2]">
            <sch:assert test="matches(normalize-space(.),'National Geospatial Data Asset')">ISO_NGDACounties.sch err#85: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="NGDAKeywordCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
            <sch:assert test="count(gmd:keyword)=4">ISO_NGDACounties.sch err#86: There are supposed to be 4 keywords</sch:assert>
            <sch:assert test="count(gmd:type)=1">ISO_NGDACounties.sch err#87: There is only supposed to be one type</sch:assert>
            <sch:assert test="contains(.,'theme')">ISO_NGDACounties.sch err#88: The gmd:MD_KeywordTypeCode should contain the value 'theme''</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking for both the WMS and REST URLS-->
    <sch:pattern id="WMSandRestCheck"> 
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]">
            <sch:assert test="count(gmd:transferOptions[1])">ISO_NGDACounties.sch err#89: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[2])">ISO_NGDACounties.sch err#90: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[3])">ISO_NGDACounties.sch err#91: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            
            <sch:assert test="count(gmd:transferOptions[4])">ISO_NGDACounties.sch err#92: The EAcontentInfo URL (for distribution) is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="RestCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            
            <sch:assert test="count(.)=1">ISO_NGDACounties.sch err#93: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <sch:assert test="count(gmd:linkage)=1">ISO_NGDACounties.sch err err#94: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2020')"> 
                ISO_NGDACounties.sch err#95:  The URL for the Rest services is wrong! It should be https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">ISO_NGDACounties.sch err#96: The application profile is missing for the REST URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">ISO_NGDACounties.sch err#97: The name is missing for REST URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">ISO_NGDACounties.sch err#98: The description is missing for the REST URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">ISO_NGDACounties.sch err#99: The function is missing for the REST URL</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <!-- Checking for WMS -->
    <sch:pattern id="WMSCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[3]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">ISO_NGDACounties.sch err#100: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            <sch:assert test="count(gmd:linkage)=1">ISO_NGDACounties.sch err#101: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')"> ISO_NGDACounties.sch err#87: Make sure you have the correct WMS URL!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'/MapServer')">ISO_NGDACounties.sch err#102: Make sure the URL ends with '/MapServer' !!</sch:assert>
            <sch:assert test="string-length(gmd:linkage/gmd:URL)&lt; 110">ISO_NGDACounties.sch err#103: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            <sch:assert test="count(gmd:applicationProfile)=1">ISO_NGDACounties.sch err#104: The application profile is missing for the WMS URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">ISO_NGDACounties.sch err#105: The name is missing for WMS URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">ISO_NGDACounties.sch err#106: The description is missing for the WMS URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">ISO_NGDACounties.sch err#107: The function is missing for the WMS URL</sch:assert>
        </sch:rule>
    </sch:pattern> 

    <sch:pattern id="ProgressCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(gmd:status)=1">ISO_NGDACounties.sch err#108: Please make sure that there is a status</sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic[1]/gmd:fileName[1]">
            <!--  <sch:assert test="starts-with((normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">The Browse graphic is incorrect. It should begin with 'https'</sch:assert>
           ://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Census2020/MapServer
            -->
            <sch:let name="BrowseGraphicURL" value="normalize-space(.)"/>
            <sch:let name="BrowseGraphicURL5" value="substring(BrowseGraphicURL,0,5)" />
            <sch:let name="tigerweb" value="tigerweb.geo.census.gov"/>
            <sch:let name="arcgis" value="arcgis"></sch:let>
            
            <sch:assert test="string( contains(BrowseGraphicURL5, 'https'))">ISO_NGDACounties.sch err#109: The URL should start with 'https'</sch:assert>
            <sch:assert test="contains($BrowseGraphicURL,'tigerweb.geo.census.gov')">ISO_NGDACounties.sch err#110: The borwse graphic should contain 'tigerweb.geo.census.gov'. It is currently <sch:value-of select="$BrowseGraphicURL"/></sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(gmd:graphicOverview)=1">ISO_NGDACounties.sch err#111: Missing the Browse Graphic</sch:assert></sch:rule>
    </sch:pattern>
    
    <sch:pattern id ="SeriesInfoMainTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:parentIdentifier[1]">
            <sch:let name="MainTitle" value="."/>
            <!--  
            <sch:assert test="$AltTitle=$MainTitle">NGDAChecksForSeriesInfoFiles_States.sch err#4c: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title (<sch:value-of select="$MainTitle"/>)+ (<sch:value-of select="$resourceTitle"/>) + (<sch:value-of select="$FileId"/> must match</sch:assert>
            <sch:report test="$AltTitle=$MainTitle">NGDAChecksForSeriesInfoFiles_States.sch err#4d: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title    (<sch:value-of select="$MainTitle"/>) must match> +  </sch:report>
            -->
            <sch:let name="Seriesitle" value="contains($MainTitle,'Series Information for the')"/>
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:let name="Theme" value="substring-after(.,'the')"/>
            <sch:assert test="$TIGERLineYes ='true'">ISO_NGDACounties.sch #112: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_NGDACounties.sch #113: The title name must contain 'Current'.</sch:assert>
            <sch:assert test="contains(.,', Series Information for the')">ISO_NGDACounties.sch #114: The title must contain ', Series Information for the'  It is <sch:value-of select="./gmd:title[1]/gco:CharacterString[1]"/>  </sch:assert>
            <sch:assert test="string-length($Theme)>2">ISO_NGDACounties.sch #115: The Series Info file should have a theme</sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="StateKeywordCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]/gmd:MD_Keywords[1]/gmd:keyword[1]">
            <sch:let name="badState" value="."/>
            <sch:report test="$badState='False'">ISO_NGDACounties.sch #116: The state name should not include "Bad State'. It is <sch:value-of select="$badState"/>  </sch:report>
        </sch:rule>
    </sch:pattern>
    
   
</sch:schema>