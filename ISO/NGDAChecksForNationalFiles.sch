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
    
   <!-- checking to make sure that the codelist value and characterset are correct -->
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">NGDAChecksForNationalFiles.sch err#1:The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern id="metadataDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]">
            <sch:let name="yearA" value="."/>
            
            <sch:assert test="contains($yearA,'2021')">NGDAChecksForNationalFiles.sch err#2: The year must be 2021. It is currently:    <sch:value-of select="$yearA"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
   <!-- Checking the alternate title -->
    <!-- Assert: if the test is false, then the test and file fails -->
    <!-- Making sure the alternate title exists -->
    <!-- This pattern works -->
    <sch:pattern id="altTitleCount">
     <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
         <sch:assert test="count(gmd:alternateTitle)=2">NGDAChecksForNationalFiles.sch err#3: At least one alternate title is missing</sch:assert>
         <sch:let name="altTitle" value="/gmd:alternateTitle/gco:CharacterString"/>
         <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
         <!--   <sch:assert test="starts-with($altTitleA,'National')">The phrase "National Geospatial Data Asset" is missing from the beginning
             of the alternate title </sch:assert>-->
     </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck1">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[2]">
            <sch:assert test="matches(normalize-space(.),'TIGER/Line Shapefile')">NGDAChecksForNationalFiles.sch err#4: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the second alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(.),'2021')">NGDAChecksForNationalFiles.sch err#5: The phrase "2021" is missing from the beginning
                of the alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]">
            <sch:assert test="matches(normalize-space(.),'National Geospatial Data Asset')">NGDAChecksForNationalFiles.sch err#6: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the first alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="BrowseGraphic_Check">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(./gmd:graphicOverview)">NGDAChecksForNationalFiles.sch err#7: The browse graphic is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='CodeIdentifierCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <sch:assert test="count(./gmd:identifier)=1">NGDAChecksForNationalFiles.sch err#8: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="identifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:identifier[1]/gmd:MD_Identifier[1]/gmd:code[1]/gco:CharacterString">
            <sch:assert test="count(.)=1">NGDAChecksForNationalFiles.sch err#9: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileIdCheck">
        <sch:rule context="/gmi:MI_Metadata">
            <sch:assert test="count(./gmd:fileIdentifier[1])=1">NGDAChecksForNationalFiles.sch err#10: The fileIdentifier is missing. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="RoorElementsCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            
            <sch:assert test="string-length(.)>15">NGDAChecksForNationalFiles.sch err#11: The filename is to short. Make sure the complete filename is there</sch:assert>
            <sch:assert test="contains(.,'.shp.iso.xml')">NGDAChecksForNationalFiles.sch err#12: The filename must contain .shp.iso.xml </sch:assert>
            <sch:assert test="contains(.,'tl_2021')">NGDAChecksForNationalFiles.sch err#13: The filename must contain 'tl_2021'</sch:assert>
        </sch:rule>
    </sch:pattern>
 
    <sch:pattern id="browseGraphicCheck1">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
              <sch:assert test="count(.)=1">NGDAChecksForNationalFiles.sch err#14 The Browse graphic is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
 
    <sch:pattern id="browseGraphicCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic[1]">
           <!--  <sch:assert test="starts-with((normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">The Browse graphic is incorrect. It should begin with 'https'</sch:assert>
           
           &VERSION
           -->
            <sch:let name="BrowseGraphicURL" value="normalize-space(./gmd:fileName[1]/gco:CharacterString)"/>
            <sch:let name="BrowseGraphicURL5" value="substring(BrowseGraphicURL,0,5)" />
          
            
            <!--  <sch:assert test="starts-with(normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">Browse Graphic</sch:assert>-->
            
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;SERVICE'))">NGDAChecksForNationalFiles.sch err#15: Make sure that there is an
                amp; after the ampersand for the SERVICE parameter</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;VERSION'))">NGDAChecksForNationalFiles.sch err#16: Make sure that there is an
                amp; after the ampersand for the VERSION parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;LAYERS'))">NGDAChecksForNationalFiles.sch err#17: Make sure that there is an
                amp; after the ampersand for the LAYERS parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;&amp;STYLES'))">NGDAChecksForNationalFiles.sch err#18: Make sure that there is an
                amp; after the ampersand for the STYLES parameter. Also, remove the double ampersand.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;STYLES'))">NGDAChecksForNationalFiles.sch err#19: Make sure that there is an
                amp; after the ampersand for the STYLES parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;FORMAT'))">NGDAChecksForNationalFiles.sch err#20: Make sure that there is an
                amp; after the ampersand for the FORMAT parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;BGCOLOR'))">NGDAChecksForNationalFiles.sch err#21: Make sure that there is an
                amp; after the ampersand for the BGCOLOR parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;TRANSPARENT'))">NGDAChecksForNationalFiles.sch err#22: Make sure that there is an
                amp; after the ampersand for the TRANSPARENT parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;CRS'))">NGDAChecksForNationalFiles.sch err#23: Make sure that there is an
                amp; after the ampersand for the CRS parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;BBOX'))">NGDAChecksForNationalFiles.sch err#24: Make sure that there is an
                amp; after the ampersand for the BBOX parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;WIDTH'))">NGDAChecksForNationalFiles.sch err#25: Make sure that there is an
                amp; after the ampersand for the WIDTH parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;HEIGHT'))">NGDAChecksForNationalFiles.sch err#26: Make sure that there is an
                amp; after the ampersand for the HEIGHT parameter.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
  
    
    <!-- Checking the keywords  and type-->
    <!-- Making sure that there are 3 keywords -->
    <!-- This pattern works -->
    <sch:pattern id="NGDAKeywordCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
            <sch:assert test="count(gmd:keyword)=4">NGDAChecksForNationalFiles.sch err#27: There are supposed to be 4 keywords</sch:assert>
            <sch:assert test="count(gmd:type)=1">NGDAChecksForNationalFiles.sch err#28: There is only supposed to be one type</sch:assert>
            <sch:assert test="contains(.,'theme')">NGDAChecksForNationalFiles.sch err#29: The gmd:MD_KeywordTypeCode should contain the value 'theme''</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct place keywords -->
    <sch:pattern id="ISO3166Check">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]/gmd:MD_Keywords[1]">
           <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> 
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:assert test="matches(normalize-space(.),'ISO 3166')">NGDAChecksForNationalFiles.sch err#30: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        </sch:rule>
    </sch:pattern>
    
   
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecksForNationalFiles.sch err#31: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">NGDAChecksForNationalFiles.sch err#32: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- Checking for both the WMS and REST URLS-->
       <sch:pattern id="WMSandRestCheck"> 
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]">
            <sch:assert test="count(gmd:transferOptions[2])">NGDAChecksForNationalFiles.sch err#33: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[2])">NGDAChecksForNationalFiles.sch err#34: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[3])">NGDAChecksForNationalFiles.sch err#35: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            
            <sch:assert test="count(gmd:transferOptions[4])">NGDAChecksForNationalFiles.sch err#36: The EAcontentInfo URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <!-- Checking the download file .-->
    <sch:pattern id="URLDownloadCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(gmd:linkage)=1">NGDAChecksForNationalFiles.sch err#37: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecksForNationalFiles.sch err#38: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecksForNationalFiles.sch err#39: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">NGDAChecksForNationalFiles.sch err#40: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecksForNationalFiles.sch err#41: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecksForNationalFiles.sch err#42: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">NGDAChecksForNationalFiles.sch err#43: The download file for the download URL must contain '.zip'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Check the Rest -->
    <sch:pattern id="RestCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
           
            <sch:assert test="count(gmd:linkage)=1">NGDAChecksForNationalFiles.sch err#45: The linkage for the REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb')"> 
                NGDAChecksForNationalFiles.sch err#46:  The URL for the Rest services is wrong! It should be https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecksForNationalFiles.sch err#47: The application profile is missing for the REST URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecksForNationalFiles.sch err#48: The name is missing for REST URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">NGDAChecksForNationalFiles.sch err#49: The description is missing for the REST URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecksForNationalFiles.sch err#50: The function is missing for the REST URL</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
     <!-- Checking for WMS -->
     <sch:pattern id="WMSCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[3]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">NGDAChecksForNationalFiles.sch err#51: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            <sch:assert test="count(gmd:linkage)=1">NGDAChecksForNationalFiles.sch err#52: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')"> NGDAChecksForNationalFiles.sch err#53: Make sure you have the correct WMS URL!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'/MapServer')">NGDAChecksForNationalFiles.sch err#54: Make sure the URL ends with '/MapServer' !!</sch:assert>
            <sch:assert test="string-length(gmd:linkage/gmd:URL)&lt; 110">NGDAChecksForNationalFiles.sch err#55: The length of the URL for the WMS is to long</sch:assert>
            
            <!--  applicationProfile-->
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecksForNationalFiles.sch err#56: The application profile is missing for the WMS URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecksForNationalFiles.sch err#57: The name is missing for WMS URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">NGDAChecksForNationalFiles.sch err#58: The description is missing for the WMS URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecksForNationalFiles.sch err#59: The function is missing for the WMS URL</sch:assert>
        </sch:rule>
     </sch:pattern> 
    
    
    <!-- /gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1] 
    
    <sch:pattern id="EaUrlCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:let name="EAUrlCheck" value="string( contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'))"/>
            <sch:assert test="$EAUrlCheck='true'">NGDAChecksForNationalFiles.sch #63A: The EA Url must contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/'</sch:assert>
        </sch:rule>
    </sch:pattern>
    -->
    
    <sch:pattern id="EaUrlCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:let name="EAUrlCheck" value="string( contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/'))"/>
            <sch:assert test="$EAUrlCheck='true'">NGDAChecksForNationalFiles.sch #60: The EA Url must contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/'</sch:assert>
        </sch:rule>
    </sch:pattern>
  
      
    <sch:pattern id="EATitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">NGDAChecksForNationalFiles.sch #61: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">NGDAChecksForNationalFiles.sch #62: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">NGDAChecksForNationalFiles.sch #63: The file name must contain '2021'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">NGDAChecksForNationalFiles.sch #64: The title should include "Shapefile'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAOtherCitationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
            <sch:let name="TLYear" value="string(contains(.,'tl_2021'))"/> 
            <sch:let name="TLDir" value="string(contains(.,'Current_19110'))"/>
            <sch:let name="EAUrlCheckEA" value="string( contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/'))"/>
            <sch:assert test="$TLYear='true'">NGDAChecksForNationalFiles.sch #65: The URL must contain 'tl_2021'.</sch:assert>
            <sch:assert test="$TLDir='true'">>NGDAChecksForNationalFiles.sch #66: The directory must be 'Current_19110'</sch:assert>
            <sch:assert test="$EAUrlCheckEA='true'">NGDAChecksForNationalFiles.sch #67: The EA Url must contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">NGDAChecksForNationalFiles.sch #68: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">NGDAChecksForNationalFiles.sch #69: The title name must contain 'Current'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    <!--  <sch:pattern> /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:applicationProfile[1]">
             <sch:assert test="ends-with(./gco:CharacterString[1],'.pdf')"></sch:assert>
        </sch:rule>
    </sch:pattern>-->
    
   <sch:pattern id="editionCheck">
       <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:edition[1]">
           <sch:let name="Year" value="string(contains(.,'2021'))"/> 
           <sch:assert test="$Year='true'">NGDAChecksForNationalFiles.sch #70: The edition name must contain '2021'.</sch:assert>
       </sch:rule>
   </sch:pattern> 
   
   <sch:pattern id="timeperiodcheck">
       <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:extent[1]/gmd:EX_Extent[1]">
           <sch:assert test="count(./gmd:geographicElement)=1">NGDAChecksForNationalFiles.sch #71: The bounding coordinates are missing</sch:assert>
           <sch:assert test="count(./gmd:temporalElement)=1">NGDAChecksForNationalFiles.sch #72: The timeperiod is missing</sch:assert>
           <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2020'))"/>
           <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2021'))"/> 
           <sch:assert test="$beginYear='true'">NGDAChecksForNationalFiles.sch #73: The beginning year must be '2020'</sch:assert>
           <sch:assert test="$endYear='true'">NGDAChecksForNationalFiles.sch #74: The ending year must be '2021'</sch:assert>
       </sch:rule>
   </sch:pattern>
   
    <sch:pattern>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">NGDAChecksForNationalFiles.sch #75: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">NGDAChecksForNationalFiles.sch #76: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">NGDAChecksForNationalFiles.sch #77: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &gt; 180)">NGDAChecksForNationalFiles.sch #78: East Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">NGDAChecksForNationalFiles.sch #79: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">NGDAChecksForNationalFiles.sch #80:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">NGDAChecksForNationalFiles.sch #81: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">NGDAChecksForNationalFiles.sch #82:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='otherConstraints'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//gmd:MD_LegalConstraints">
            <sch:report test="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">NGDAChecksForNationalFiles.sch #83: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd:otherConstraints must be documented.</sch:report>
            <sch:report test="gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">NGDAChecksForNationalFiles.sch #84: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd:otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='distributionFormatCheck'>
        <sch:title>gmd:MD_Distribution</sch:title>
        <sch:rule context="//gmd:MD_Distribution">
            <sch:assert test="count(gmd:distributionFormat)&gt;0 or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)&gt;0">NGDAChecksForNationalFiles.sch #85: You must provide either gmd:distributionFormat or gmd:distributorFormat.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1] 
         /gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]/gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1]
   <sch:report test="string-length(.)>20">NGDAChecksForNationalFiles.sch #86: The file id is not complete. Please fill it out. <sch:value-of select="$fileStringLength"/></sch:report>
    -->
    <sch:pattern id="datasourcecheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]">
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">NGDAChecksForNationalFiles.sch #86: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">NGDAChecksForNationalFiles.sch #87: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">NGDAChecksForNationalFiles.sch #88: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>
   
   <sch:pattern id='hiearchyLevelCheck'>
       <sch:rule context="/gmi:MI_Metadata/gmd:hierarchyLevel[1]/gmd:MD_ScopeCode[1]/@codeListValue">
           <sch:let name="hierlevel" value="."/>
           <sch:assert test=".='dataset'">NGDAChecksForNationalFiles.sch #89: The hierarchy level must be 'dataset' </sch:assert>
           
       </sch:rule>
   </sch:pattern>
   
    <sch:pattern id='DataIdentificationExtent'>
        <sch:title>gmd:MD_DataIdentification Extent</sch:title>
        <sch:rule context="//gmd:MD_DataIdentification">
            <sch:report test="(not(gmd:hierarchyLevel) or gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset') and (count(//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox) + count (//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicDescription)) =0">
                NGDAChecksForNationalFiles.sch #90: If the metadata gmd:hierarchyLevel code = 'dataset' then you must document gmd:EX_GeographicBoundingBox or gmd:EX_GeographicDescription.</sch:report>
        </sch:rule>
    </sch:pattern>
     
    <!-- /gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString[1] -->
    <sch:pattern id='datasetURlCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:dataSetURI[1]">
            <sch:assert  test="contains(.,'https')">NGDAChecksForNationalFiles.sch #91: The URI should contain 'https'</sch:assert>
            <sch:assert test="contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19115/')">NGDAChecksForNationalFiles.sch #92: The file's URI should have 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19115/'</sch:assert>
            <sch:report test="contains(.,'http://')">NGDAChecksForNationalFiles.sch #93: There should not be a 'http://' in the dataset Url </sch:report>
        </sch:rule>
    </sch:pattern>
   
   <sch:pattern>
       <sch:rule context="/gmi:MI_Metadata/gmd:dataSetURI[1]">
           <sch:assert  test="contains(.,'https')">NGDAChecksForNationalFiles.sch #94: The URL should contain 'https'</sch:assert>
       </sch:rule>
   </sch:pattern>
   
    <sch:pattern id="statusCheck1">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(gmd:status)=1">NGDAChecksForNationalFiles.sch #95: Please make sure that there is a status</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="statusCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:status[1]/gmd:MD_ProgressCode[1]//@codeListValue">
            <sch:assert test=".='completed'">NGDAChecksForNationalFiles.sch #96: The status must be 'completed'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
