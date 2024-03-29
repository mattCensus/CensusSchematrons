<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi" />
    <sch:ns  prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:let name="resourceTitle"
        value="/gmd:MD_Metadata[1]/gmd:identificationInfo[1]/*[1]/gmd:citation/*[1]/gmd:title/*[1][normalize-space()]"/>
    <sch:let name="FileId" value="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]"/>
   
   
    
      <!-- Assert: if the test is false, then the test and file fails -->
   <!-- checking to make sure that the codelist value and characterset are correct -->
    <!-- checking to make sure that the codelist value and characterset are correct -->
    <!-- 
        Change log
        12/15/17 added the "https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer "
        WMS to the checks
    -->
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">NGDAChecksForSeriesInfoFiles_States.sch err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <!-- Checking the alternate title -->
  
    <sch:pattern id="altTitleCount" >
        <sch:p> Making sure the alternate title exists </sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation">
            <sch:assert test="count(gmd:alternateTitle)=2">NGDAChecksForSeriesInfoFiles_States.sch err#2: There should be two alternate title</sch:assert>
         <sch:let name="altTitle" value="./gmd:alternateTitle[1]/gco:CharacterString[1]"/>
         <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
     </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='TitleConsistencyCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation">
            <sch:let name="MainTitle" value="substring-after(./gmd:title[1],'for the')"/>  
            
            <sch:let name="altTitleOne" value="./gmd:alternateTitle[1]"/>
            <sch:let name="NGDAThemeTwo" value="normalize-space($altTitleOne)"/>
            <sch:let name="NGDAThemeA" value="substring-after($NGDAThemeTwo,'(Census)')"/>
            
            <sch:let name="altTitleThree" value="./gmd:alternateTitle[2]"/>
            <sch:let name="NGDAThemefour" value="normalize-space($altTitleThree)"/>
            <sch:let name="ThemeFive" value="substring($NGDAThemefour,38)"/>
            <sch:let name="NGDAThemeB" value="substring($NGDAThemefour,38)"/>
            
            <sch:let name="YearTitle" value="string(contains(./gmd:title[1],'Current'))"/>
            
            <sch:assert test="$YearTitle='true'">NGDAChecksForSeriesInfoFiles_States.sch err# #3: The title name must contain 'Current'.</sch:assert>
            
            <sch:assert test="contains($MainTitle,$NGDAThemeA)">NGDAChecksForSeriesInfoFiles_States.sch err#4:The main title <sch:value-of select="$MainTitle"/> and the NGDA Theme in the first alternate title (<sch:value-of select="$NGDAThemeA"/>) do not match</sch:assert>
            <sch:assert test="contains($MainTitle,$ThemeFive)">NGDAChecksForSeriesInfoFiles_States.sch err#5:The Main title (<sch:value-of select="$MainTitle"/>) and the NGDA Theme in the second alternate title (<sch:value-of select="$NGDAThemeB"/>) do not match
         
                Themefive is (<sch:value-of select="$ThemeFive"/>).
            </sch:assert>
            <!--   
                AltTitleThree is (<sch:value-of select="$altTitleThree"/>). NGDAThemefour is (<sch:value-of select="$NGDAThemefour"/>)
                <sch:report test="contains($MainTitle,$NGDAThemeA)">(<sch:value-of select="$NGDAThemeA"/>) is the main title</sch:report> Census  for the-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck1">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]">
            <sch:assert test="matches(normalize-space(.),'TIGER/Line Shapefile')">NGDAChecksForSeriesInfoFiles_States.sch err#6: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the FIRST alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(.),'2021')">NGDAChecksForSeriesInfoFiles_States.sch err#7: The phrase "2021" is missing from the beginning
                of the FIRST alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[2]">
            <sch:assert test="matches(normalize-space(.),'National Geospatial Data Asset')">NGDAChecksForSeriesInfoFiles_States.sch err#8: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the SECOND alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ="SeriesInfoMainTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="MainTitle" value="."/>
            <!--  
            <sch:assert test="$AltTitle=$MainTitle">NGDAChecksForSeriesInfoFiles_States.sch err#4c: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title (<sch:value-of select="$MainTitle"/>)+ (<sch:value-of select="$resourceTitle"/>) + (<sch:value-of select="$FileId"/> must match</sch:assert>
            <sch:report test="$AltTitle=$MainTitle">NGDAChecksForSeriesInfoFiles_States.sch err#4d: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title    (<sch:value-of select="$MainTitle"/>) must match> +  </sch:report>
            -->
            <sch:let name="Seriesitle" value="contains($MainTitle,'Series Information for the')"/>
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">NGDAChecksForSeriesInfoFiles_States.sch #9: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">NGDAChecksForSeriesInfoFiles_States.sch #10: The title name must contain 'Current'.</sch:assert>
            <sch:assert test="contains(.,', Series Information for the')">NGDAChecksForSeriesInfoFiles_States.sch #11: The title must contain ', Series Information for the'  It is <sch:value-of select="./gmd:title[1]/gco:CharacterString[1]"/>  </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">NGDAChecksForSeriesInfoFiles_States.sch err #12: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">NGDAChecksForSeriesInfoFiles_States.sch err#13: The title name must contain 'Current'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Browse Graphic -->
    
    <sch:pattern id="browseGraphicCountCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(gmd:graphicOverview)=1">NGDAChecksForSeriesInfoFiles_States.sch err#14: The Browse Graphic is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCheck2">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic[1]">
            <!--  <sch:assert test="starts-with((normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">The Browse graphic is incorrect. It should begin with 'https'</sch:assert>
           
           &VERSION
           -->
            <sch:let name="BrowseGraphicURL" value="normalize-space(./gmd:fileName[1]/gco:CharacterString)"/>
            <sch:let name="BrowseGraphicURL5" value="substring(BrowseGraphicURL,0,5)" />
            <sch:assert test="count(.)=1">NGDAChecksForSeriesInfoFiles_States.sch err#8 The Browse graphic is missing</sch:assert>
            
            <!--  <sch:assert test="starts-with(normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">Browse Graphic</sch:assert>-->
            
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;SERVICE'))">NGDAChecksForSeriesInfoFiles_States.sch err#15: Make sure that there is an
                amp; after the ampersand for the SERVICE parameter</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;VERSION'))">>NGDAChecksForSeriesInfoFiles_States.sch err#16: Make sure that there is an
                amp; after the ampersand for the VERSION parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;LAYERS'))">>NGDAChecksForSeriesInfoFiles_States.sch err#17: Make sure that there is an
                amp; after the ampersand for the LAYERS parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;&amp;STYLES'))">NGDAChecksForSeriesInfoFiles_States.sch err#18: Make sure that there is an
                amp; after the ampersand for the STYLES parameter. Also, remove the double ampersand.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;STYLES'))">>NGDAChecksForSeriesInfoFiles_States.sch err#19: Make sure that there is an
                amp; after the ampersand for the STYLES parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;FORMAT'))">>NGDAChecksForSeriesInfoFiles_States.sch err#20: Make sure that there is an
                amp; after the ampersand for the FORMAT parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;BGCOLOR'))">>NGDAChecksForSeriesInfoFiles_States.sch err#21: Make sure that there is an
                amp; after the ampersand for the BGCOLOR parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;TRANSPARENT'))">>NGDAChecksForSeriesInfoFiles_States.sch err#22: Make sure that there is an
                amp; after the ampersand for the TRANSPARENT parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;CRS'))">>NGDAChecksForSeriesInfoFiles_States.sch err#23: Make sure that there is an
                amp; after the ampersand for the CRS parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;BBOX'))">NGDAChecksForSeriesInfoFiles_States.sch err#24: Make sure that there is an
                amp; after the ampersand for the BBOX parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;WIDTH'))">NGDAChecksForSeriesInfoFiles_States.sch err#25: Make sure that there is an
                amp; after the ampersand for the WIDTH parameter.</sch:assert>
            <sch:assert test="not(contains(./gmd:fileName[1]/gco:CharacterString[1],'&amp;HEIGHT'))">NGDAChecksForSeriesInfoFiles_States.sch err#26: Make sure that there is an
                amp; after the ampersand for the HEIGHT parameter.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the NGDA keywords  and type-->
    <sch:pattern>
        <sch:p>Making sure that there are 4 keywords, 1 type and that the type is theme </sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
            <sch:assert test="count(gmd:keyword)=4">NGDAChecksForSeriesInfoFiles_States.sch err#27: There are supposed to be 4 keywords</sch:assert>
            <sch:assert test="count(gmd:type)=1">NGDAChecksForSeriesInfoFiles_States.sch err#28: There is only supposed to be one type</sch:assert>
            <sch:assert test="contains(.,'theme')">NGDAChecksForSeriesInfoFiles_States.sch err#29: The gmd:MD_KeywordTypeCode should contain the value 'theme''</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct place keywords -->
    <sch:pattern>
        <sch:p>Making sure the value is 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]/gmd:MD_Keywords[1]">
            <sch:assert test="matches(normalize-space(.),'ISO 3166')">NGDAChecksForSeriesInfoFiles_States.sch err#30: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the URLS -->
    <sch:pattern id="WMSandRestCheck">
        <sch:p> Checking for correct amount of URLS </sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]">
            <sch:assert test="count(gmd:transferOptions)=5">NGDAChecksForSeriesInfoFiles_States.sch #31: There should be five URLs</sch:assert>
            <sch:assert test="count(gmd:transferOptions[2])=1">NGDAChecksForSeriesInfoFiles_States.sch err#32: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[2])=1">NGDAChecksForSeriesInfoFiles_States.sch err#33: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[3])=1">NGDAChecksForSeriesInfoFiles_States.sch err#34: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            
            <sch:assert test="count(gmd:transferOptions[4])=1">NGDAChecksForSeriesInfoFiles_States.sch err#35: The EAcontentInfo URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    <sch:pattern id="URLDownloadCheck">
        <sch:p>Checking for the zip file</sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:report test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">NGDAChecksForSeriesInfoFiles_States.sch err#36: There should not be a zip file for the download</sch:report>
            <sch:assert test="count(gmd:linkage)=1">NGDAChecksForSeriesInfoFiles_States.sch err#37: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecksForSeriesInfoFiles_States.sch err#38: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecksForSeriesInfoFiles_States.sch err#39: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">NGDAChecksForSeriesInfoFiles_States.sch err#40: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecksForSeriesInfoFiles_States.sch err#41: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecksForSeriesInfoFiles_States.sch err#42: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2021/')">NGDAChecksForSeriesInfoFiles_States.sch err#43: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2021'</sch:assert>
            <sch:report test="contains(./gmd:description[1],'C:/Users')">NGDAChecksForSeriesInfoFiles_States.sch err#44: This should not contain "C:/Users" </sch:report>
            <sch:let name="descriptionLength" value="string-length(./gmd:description[1]/gco:CharacterString[1])"/>
            <sch:report test="$descriptionLength>1">NGDAChecksForSeriesInfoFiles_States.sch err#45: The string lenght is  <sch:value-of select="$descriptionLength"/></sch:report>
            <sch:report test="contains(./gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download!!')">NGDAChecksForSeriesInfoFiles_States.sch err#46:  This attribute should not contain !!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="tigerdocCheck">
        <sch:p>checking for the correct URL for the TIGER page</sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecksForSeriesInfoFiles_States.sch err#47: he TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">NGDAChecksForSeriesInfoFiles_States.sch err#48: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="TIGERCheck">
        <sch:p>checking for the correct URL for the TIGER page</sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecksForSeriesInfoFiles_States.sch err#49: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">NGDAChecksForSeriesInfoFiles_States.sch err#50: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking for both the WMS and REST URLS       <sch:assert test="count(gmd:transferOptions)">NGDAChecksForSeriesInfoFiles_States.sch err#14: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>      -->
  
    <!-- NGDAChecksForSeriesInfoFiles_States.sch -->
    <!-- This pattern works -->
    <sch:pattern id="WMSCheck">
         <sch:p>Checking for WMS and making sure that it exists</sch:p>
         <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">NGDAChecksForSeriesInfoFiles_States.sch err#51:The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            <sch:assert test="count(gmd:linkage)=1">NGDAChecksForSeriesInfoFiles_States.sch err#52: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            
             <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')
                or contains(gmd:linkage/gmd:URL, 'https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer')
                or contains(gmd:linkage/gmd:URL, 'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_PhysicalFeatures/MapServer')">
                 NGDAChecksForSeriesInfoFiles_States.sch err#53: Make sure you have the correct URL for the WMS (https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer ) !!</sch:assert>
            
             <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'/MapServer')">NGDAChecksForSeriesInfoFiles_States.sch err#54: Make sure you have the correct URL !!</sch:assert>
            <sch:assert test="string-length(gmd:linkage/gmd:URL)&lt; 103">NGDAChecksForSeriesInfoFiles_States.sch err#55: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecksForSeriesInfoFiles_States.sch err#56: The application profile is missing for the WMS URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecksForSeriesInfoFiles_States.sch err#57: The name is missing for WMS URL</sch:assert>
             <sch:assert test="count(gmd:description)=1">NGDAChecksForSeriesInfoFiles_States.sch err#58: The description is missing for the WMS URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecksForSeriesInfoFiles_States.sch err#59: The function is missing for the WMS URL</sch:assert>
        </sch:rule>
     </sch:pattern> 
    
    
    
    <sch:pattern id="RESTURLCheck">
        <sch:p>Checking for REST and making sure that it exists</sch:p>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[5]/gmd:MD_DigitalTransferOptions[1]">
            <sch:assert test="count(.)=1">NGDAChecksForSeriesInfoFiles_States.sch err#60: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <sch:assert test="count(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1])=1">NGDAChecksForSeriesInfoFiles_States.sch err#61: The linkage is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:applicationProfile[1])=1">NGDAChecksForSeriesInfoFiles_States.sch err#62: The application profile is missing for the REST URL </sch:assert>
            <sch:assert test="count(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:name[1])=1">NGDAChecksForSeriesInfoFiles_States.sch err#63: The name is missing for REST URL</sch:assert>
            <sch:assert test="count(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:description[1])=1">NGDAChecksForSeriesInfoFiles_States.sch err#64: The description is missing for the REST URL</sch:assert>
            <sch:assert test="count(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:function[1])=1">NGDAChecksForSeriesInfoFiles_States.sch err#65: The function is missing for the REST URL</sch:assert>
            <sch:assert test="contains(./gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(./gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2010') ">
                NGDAChecksForSeriesInfoFiles_States.sch err#66: The URL for the REST URL is wrong is wrong! It should be "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb"</sch:assert>
           
        </sch:rule>
    </sch:pattern> 
    
    
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:edition[1]">
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:assert test="$Year='true'">NGDAChecksForSeriesInfoFiles_States.sch #67: The edition name must contain '2021'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:extent[1]/gmd:EX_Extent[1]">
            <sch:assert test="count(./gmd:geographicElement)=1">NGDAChecksForSeriesInfoFiles_States.sch #68: The bounding coordinates are missing</sch:assert>
            <sch:assert test="count(./gmd:temporalElement)=1">NGDAChecksForSeriesInfoFiles_States.sch #69: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2020'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2021'))"/> 
            <sch:assert test="$beginYear='true'">NGDAChecksForSeriesInfoFiles_States.sch #70: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">NGDAChecksForSeriesInfoFiles_States.sch #71: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBox'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">NGDAChecksForSeriesInfoFiles_States.sch #72: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">NGDAChecksForSeriesInfoFiles_States.sch #73: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">NGDAChecksForSeriesInfoFiles_States.sch #74: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">NGDAChecksForSeriesInfoFiles_States.sch #75: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">NGDAChecksForSeriesInfoFiles_States.sch #76: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">NGDAChecksForSeriesInfoFiles_States.sch #77:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">NGDAChecksForSeriesInfoFiles_States.sch #78: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">NGDAChecksForSeriesInfoFiles_States.sch #79:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='otherRestrictionInMD_LegalConstraints'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//gmd:MD_LegalConstraints">
            <sch:report test="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">NGDAChecksForSeriesInfoFiles_States.sch #80: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">NGDAChecksForSeriesInfoFiles_States.sch #81: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='distributionFormat'>
        <sch:title>gmd:MD_Distribution</sch:title>
        <sch:rule context="//gmd:MD_Distribution">
            <sch:assert test="count(gmd:distributionFormat)&gt;0 or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)&gt;0">NGDAChecksForSeriesInfoFiles_States.sch #82: You must provide either gmd:distributionFormat or gmd:distributorFormat.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="datasourcecheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]">
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">NGDAChecksForSeriesInfoFiles_States.sch #83: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">NGDAChecksForSeriesInfoFiles_States.sch #84: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">NGDAChecksForSeriesInfoFiles_States.sch #85: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>  
    
    
    <sch:pattern id="scopeCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:hierarchyLevel[1]/gmd:MD_ScopeCode[1]/@codeListValue">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='series'">NGDAChecksForSeriesInfoFiles_States.sch #86: The hierarchy level must be 'series' </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    
    
    
       
   
   
</sch:schema>
