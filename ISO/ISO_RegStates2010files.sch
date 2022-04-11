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
    
    
    <!-- Checking the alternate title -->
    <!-- Assert: if the test is false, then the test and file fails -->
    <!-- Making sure the alternate title exists -->
    <!-- This pattern works -->
    <sch:pattern id="altTitleCount">
        <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
            <sch:assert test="count(gmd:alternateTitle)=0">ISO_RegStates2010files.sch err#1: There should be no alternate titles</sch:assert>
   <!-- checking to make sure that the codelist value and characterset are correct -->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">ISO_RegStates2010files.sch err#2:The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern id="metadataDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date">
            <sch:let name="yearA" value="."/>
            <sch:assert test="$yearA = '2020'" >ISO_RegStates2010files.sch err#3: The year must be 2020. It is currently:    <sch:value-of select="$yearA"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
   <!-- Checking the alternate title -->
    <!-- Assert: if the test is false, then the test and file fails -->
    <!-- Making sure the alternate title exists -->
    <!-- This pattern works -->
   
     
    <sch:pattern id='CodeIdentifier'>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <sch:assert test="count(./gmd:identifier)=1">ISO_RegStates2010files.sch err#4: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="identifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:identifier[1]/gmd:MD_Identifier[1]/gmd:code[1]/gco:CharacterString">
            <sch:assert test="count(.)=1">ISO_RegStates2010files.sch err#5: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="RootElementsCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]">
            <sch:assert test="count(.)=1">ISO_RegStates2010files.sch err#6: The fileIdentifier is missing. </sch:assert>
            <sch:assert test="string-length(.)>15">ISO_RegStates2010files.sch err#7: The filename is to short. Make sure the complete filename is there</sch:assert>
            <sch:assert test="contains(.,'.shp.iso.xml')">ISO_RegStates2010files.sch err#8: The filename must contain .shp.iso.xml </sch:assert>
            <sch:assert test="contains(.,'tl_2020')">ISO_RegStates2010files.sch err#9: The filename must contain 'tl_2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct place keywords
    /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]
    -->
    <sch:pattern id="ISO3166Check">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]">
            <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> 
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:let name="PlaceThes" value="string-length(.)"/>
            <sch:assert test="matches(normalize-space(.),'38-2009')">ISO_RegStates2010files.sch err#10: The value for the thesauraus should be 'National Standard Codes (ANSI INCITS 38-2009), Federal Information Processing Series (FIPS) – States/State Equivalents' </sch:assert>
            <sch:assert test="$PlaceThes  &lt; 529">ISO_RegStates2010files.sch err#11: Make Sure the value for the Place Thesaurus is correct. It has a length of <sch:value-of select="$PlaceThes"/>. It should be greater than 529 characters.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_RegStates2010files.sch err#12: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">ISO_RegStates2010files.sch err#13: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- Checking the download file .-->
    <!--                    /gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:description[1]/gco:CharacterString[1] -->
    <sch:pattern id="URLDownloadCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(gmd:linkage)=1">ISO_RegStates2010files.sch err#14: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">ISO_RegStates2010files.sch err#15: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">ISO_RegStates2010files.sch err#16: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">ISO_RegStates2010files.sch err#17: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">ISO_RegStates2010files.sch err#18: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_RegStates2010files.sch err#19: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">ISO_RegStates2010files.sch err#20: The download file for the download URL must contain '.zip'</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER')">ISO_RegStates2010files.sch err#21: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER'</sch:assert>
            <sch:report test="contains(./gmd:description[1],'C:/Users')">ISO_RegStates2010files.sch err#22: This should not contain "C:/Users" </sch:report>
            <sch:let name="descriptionLength" value="string-length(./gmd:description[1]/gco:CharacterString[1])"/>
            <sch:report test="$descriptionLength>1">ISO_RegStates2010files.sch err#23: The string lenght is  <sch:value-of select="$descriptionLength"/></sch:report>
            <sch:report test="contains(./gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download!!')">ISO_RegStates2010files.sch err#24:  This attribute should not contain !!!</sch:report>
        </sch:rule>
    </sch:pattern>
    <!--  / -->
    <sch:pattern id="EATitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">ISO_RegStates2010files.sch err#25: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">ISO_RegStates2010files.sch err#26: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">ISO_RegStates2010files.sch err#27: The file name must contain '2020'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">ISO_RegStates2010files.sch err#28: The title should include "Shapefile'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAOtherCitationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
            <sch:let name="TLYear" value="string(contains(.,'tl_2020'))"/> 
            <sch:let name="TLDir" value="string(contains(.,'TIGER2020'))"/>
            <sch:let name="EAUrlCheckEA" value="string( contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'))"/>
            <sch:assert test="$TLYear='true'">ISO_RegStates2010files.sch err#29: The URL must contain 'tl_2020'.</sch:assert>
            <sch:assert test="$TLDir='true'">ISO_RegStates2010files.sch err#30: The directory must be 'Tiger2020'</sch:assert>
            <sch:assert test="$EAUrlCheckEA='true'">ISO_RegStates2010files.sch err#31: The EA Url must contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="TigerTitle" value="string(contains(.,'TIGER/Line Shapefile, 2020, 2010 state,'))"></sch:let>
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:let name="Year2010" value="string(contains(.,'2010'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">ISO_RegStates2010files.sch err#32: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_RegStates2010files.sch err#33: The title name must contain '2020'.</sch:assert>
            <sch:assert test="$Year2010='true'">ISO_RegStates2010files.sch err#34: The title name must contain '2010'.</sch:assert>
            <sch:assert test="$TigerTitle='true'">ISO_RegStates2010files.sch err#35: The title should contain TIGER/Line Shapefile, 2020, 2010,</sch:assert>
        </sch:rule>
    </sch:pattern>
    <!--  <sch:pattern> /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:applicationProfile[1]">
             <sch:assert test="ends-with(./gco:CharacterString[1],'.pdf')"></sch:assert>
        </sch:rule>
    </sch:pattern>
    TIGER/Line Shapefile, 2020, 2010 state,
    /gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution/gmd:transferOptions[1]
    -->
    
   <sch:pattern id="editionCheck">
       <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:edition[1]">
           <sch:let name="Year" value="string(contains(.,'2020'))"/> 
           <sch:assert test="$Year='true'">ISO_RegStates2010files.sch err#36: The edition name must contain '2020'. This is the year the shapefile was released</sch:assert>
       </sch:rule>
   </sch:pattern> 
   
   <sch:pattern id="timeperiodcheck">
       <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:extent[1]/gmd:EX_Extent[1]">
           <sch:assert test="count(./gmd:geographicElement)=1">ISO_RegStates2010files.sch err#37: The bounding coordinates are missing</sch:assert>
           <sch:assert test="count(./gmd:temporalElement)=1">ISO_RegStates2010files.sch err#38: The timeperiod is missing</sch:assert>
           <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2009'))"/>
           <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2010'))"/> 
           <sch:assert test="$beginYear='true'">ISO_RegStates2010files.sch err#39: The beginning year must be '2009'</sch:assert>
           <sch:assert test="$endYear='true'">ISO_RegStates2010files.sch err#40: The ending year must be '2010'</sch:assert>
       </sch:rule>
   </sch:pattern>
   
    <sch:pattern id="BoundingCoordinates">
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">ISO_RegStates2010files.sch err#41: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">ISO_RegStates2010files.sch err#42: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_RegStates2010files.sch err#43: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_RegStates2010files.sch err#44: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">ISO_RegStates2010files.sch err#45: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">ISO_RegStates2010files.sch err#46:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">ISO_RegStates2010files.sch err#47: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">ISO_RegStates2010files.sch err#48:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="OtherRestrictionsCheck">
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//gmd:MD_LegalConstraints">
            <sch:report test="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_RegStates2010files.sch err#49: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_RegStates2010files.sch err#50: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>gmd:MD_Distribution</sch:title>
        <sch:rule context="//gmd:MD_Distribution">
            <sch:assert test="count(gmd:distributionFormat)&gt;0 or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)&gt;0">ISO_RegStates2010files.sch err#53: You must provide either gmd:distributionFormat or gmd:distributorFormat.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1] 
         /gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]/gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1]
   <sch:report test="string-length(.)>20">NGDAChecksForNationalFiles.sch #86: The file id is not complete. Please fill it out. <sch:value-of select="$fileStringLength"/></sch:report>
    -->
    <sch:pattern id="datasourcecheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]">
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2009'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2010'))"/> 
            <sch:assert test="$beginYear='true'">ISO_RegStates2010files.sch err#54: The beginning year must be '2009'</sch:assert>
            <sch:assert test="$endYear='true'">ISO_RegStates2010files.sch err#55: The ending year must be '2010'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">ISO_RegStates2010files.sch err#56: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>
   
   <sch:pattern id="scopeCheck">
       <sch:rule context="/gmi:MI_Metadata/gmd:hierarchyLevel[1]/gmd:MD_ScopeCode[1]/@codeListValue">
           <sch:let name="hierlevel" value="."/>
           <sch:assert test=".='dataset'">ISO_RegStates2010files.sch err#57: The hierarchy level must be 'dataset' </sch:assert>
           
       </sch:rule>
   </sch:pattern>
   
    <sch:pattern id="datasetBoundingBoxCheck">
        <sch:title>gmd:MD_DataIdentification Extent</sch:title>
        <sch:rule context="//gmd:MD_DataIdentification">
            <sch:report test="(not(gmd:hierarchyLevel) or gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset') and (count(//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox) + count (//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicDescription)) =0">
                ISO_RegStates2010files.sch err#58: If the metadata gmd:hierarchyLevel code = 'dataset' then you must document gmd:EX_GeographicBoundingBox or gmd:EX_GeographicDescription.</sch:report>
        </sch:rule>
    </sch:pattern>
     
    <!-- /gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString[1] -->
   
   <sch:pattern id='datasetURlCheck'>
       <sch:rule context="/gmi:MI_Metadata/gmd:dataSetURI[1]">
           <sch:assert  test="contains(.,'https')">ISO_RegStates2010files.sch err#59: The URL should contain 'https'</sch:assert>
           <sch:assert test="contains(.,'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER')">ISO_RegStates2010files.sch err#60: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER'</sch:assert>
           <sch:report test="contains(.,'http://')">ISO_RegStates2010files.sch err#61: There should not be a 'http://' in the dataset Url </sch:report>
       </sch:rule>
   </sch:pattern>
    
    <sch:pattern id="EaUrlCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:let name="EAUrlCheck" value="string( contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'))"/>
            <sch:assert test="$EAUrlCheck='true'">ISO_RegStates2010files.sch err#62: The EA Url must contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'</sch:assert>
        </sch:rule>
    </sch:pattern>
   
</sch:schema>
