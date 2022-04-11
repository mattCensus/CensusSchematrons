<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:let name="Title" value="/GPM/Identification_Information[1]/Citation[1]/Title[1]"/>
    <sch:let name="TitleTheme" value="substring-after($Title,'for the')"/>
    
    <sch:let name="OnlineLinkage" value="/GPM/Identification_Information[1]/Citation[1]/Online_Linkage[1]"/>
    <sch:let name="OnlineLinkageTheme" value="substring-after($OnlineLinkage,'TIGER2020/')"></sch:let>
    
    <sch:let name="NetResName" value="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]/Network_Address[1]/Network_Resource_Name[1]"/>
    <sch:let name="NetResNameTheme" value="substring-after($NetResName,'TIGER2020/')"/>
    <sch:let name="NetResNameTheme2" value="substring-before($NetResNameTheme,'/')"/>
    
    <sch:let name="MetFileId" value="/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1]"/>
    <sch:let name="MetFileId2" value="substring-after($MetFileId,'2020_')"/>
    <sch:let name="MetFileId3" value="substring-before($MetFileId2,'.')"/>
    <sch:let name="MetFileId4" value="upper-case($MetFileId3)"/>
    <sch:let name="MetFileId5" value="translate($MetFileId3,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    
    <sch:let name="edition" value="string(/GPM/Identification_Information[1]/Citation[1]/Edition[1])"/>
    <sch:let name="editionVer" value="xs:string(substring($edition,5,2))"/>
    
        
        
    <!-- translate(mytext,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ') -->
    
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Data_Set_Character_Set[1]">
            <sch:assert test="contains(.,'UTF-8')">GPM_ChecksForSeriesInfoFilesReg.schh err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCount" >
        <sch:p> Making sure the alternate title exists </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(Alternate_Title)=2">GPM_ChecksForSeriesInfoFilesReg.schh err#2: There should be two alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCheck1">
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/Alternate_Title[1]">
            <sch:assert test="matches(normalize-space(.),'2020')">ISO_ChecksForStates.sch err#3: The phrase "2020" is missing from the beginning
                of the alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(.),'TIGER/Line Shapefile')">ISO_ChecksForStates.sch err#4: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ="SeriesInfoMainTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="MainTitle" value="."/>
            <!--  
            <sch:assert test="$AltTitle=$MainTitle">GPM_ChecksForSeriesInfoFilesReg.schh err#4c: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title (<sch:value-of select="$MainTitle"/>)+ (<sch:value-of select="$resourceTitle"/>) + (<sch:value-of select="$FileId"/> must match</sch:assert>
            <sch:report test="$AltTitle=$MainTitle">GPM_ChecksForSeriesInfoFilesReg.schh err#4d: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title    (<sch:value-of select="$MainTitle"/>) must match> +  </sch:report>
            -->
            <sch:let name="Seriesitle" value="contains($MainTitle,'Series Information for the')"/>
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">GPM_ChecksForSeriesInfoFilesReg.schh #5: The main title should include 'TIGER/Line Shapefile'</sch:assert>
           
            <sch:assert test="contains(.,', Series Information for the')">GPM_ChecksForSeriesInfoFilesReg.schh #6: The title must contain ', Series Information for the'  It is <sch:value-of select="/GPM/Identification_Information[1]/Citation[1]/Title[1]"/>  </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">ISO_ChecksForStates.sch #7: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_ChecksForStates.sch #8: The title name must contain '2020'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCountCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Browse_Graphic[1]">
            <sch:assert test="count(Browse_Graphic_File_Name)=1">GPM_ChecksForSeriesInfoFilesReg.schh err#9: The Browse Graphic is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    <!-- Checking the NGDA keywords  and type-->
    <sch:pattern>
        <sch:p>Making sure that there are 4 keywords, 1 type and that the type is theme </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(NGDA_Keyword)=3">GPM_ChecksForSeriesInfoFilesReg.schh err#10: There are supposed to be 3 keywords</sch:assert>
            <sch:assert test="contains(./NGDA_Keyword_Thesaurus[1],'NGDA Portfolio Themes')">GPM_ChecksForSeriesInfoFilesReg.schh err#11: The gmd:MD_KeywordTypeCode should contain the value 'NGDA Portfolio Themes''</sch:assert>
        </sch:rule>
    </sch:pattern>


<!-- checking for the correct place keywords -->
<sch:pattern>
    <sch:p>Making sure the value is 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:p>
    <sch:rule context="/GPM/Identification_Information[1]/Keywords[1]/Place[1]">
        <sch:assert test="matches(normalize-space(./Place_Keyword_Thesaurus[1]),'ISO 3166')">GPM_ChecksForSeriesInfoFilesReg.schh err#12: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        <sch:assert test="count(./Place_Keyword)=2"></sch:assert>
    </sch:rule>
</sch:pattern>

    <!-- Checking the URLS -->
    <sch:pattern id="WMSandRestCheck">
        <sch:p> Checking for correct amount of URLS </sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]">
            <sch:assert test="count(Digital_Form)=3">NGDAChecksForNationalFiles.sch #25: There should be three URLs</sch:assert>
            <sch:assert test="count(./Digital_Form[1]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_ChecksForSeriesInfoFilesReg.sch err#13: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(./Digital_Form[2]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_ChecksForSeriesInfoFilesReg.schh err#14: The EAcontentInfo URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(./Digital_Form[3]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_ChecksForSeriesInfoFilesReg.schh err#15: The Technical Documentation URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    

    <sch:pattern id="URLDownloadCheck">
        <sch:p>Checking for the zip file</sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]">
            <sch:report test="contains(./Network_Address[1]/Network_Resource_Name[1],'.zip')">GPM_ChecksForSeriesInfoFilesReg.schh err#16: There should not be a zip file for the download</sch:report>
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https')">GPM_ChecksForSeriesInfoFilesReg.schh err#17: The linkage for the download URL does not contains https</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern id="WMSCheck">
        <sch:p>Checking for WMS and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/GETMAP_URL[1]">
            <sch:assert test="count(.)=1">GPM_ChecksForSeriesInfoFilesReg.schh err#39:The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            
            
            <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')
                or contains(., 'https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer')
                or contains(., 'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_PhysicalFeatures/MapServer')">
                GPM_ChecksForSeriesInfoFilesReg.schh err#18: Make sure you have the correct URL for the WMS (https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer ) !!</sch:assert>
            
            <sch:assert test="contains(.,'/MapServer')">GPM_ChecksForSeriesInfoFilesReg.schh err#19:Make sure you have the correct URL !!</sch:assert>
            <sch:assert test="string-length(.)&lt; 103">GPM_ChecksForSeriesInfoFilesReg.schh err#20: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="RESTURLCheck">
        <sch:p>Checking for REST and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/REST_URL[1]">
            <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2010') ">
                GPM_ChecksForSeriesInfoFilesReg.schh err#21: The URL for the REST URL is wrong is wrong! It should be "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb"</sch:assert>
            
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Edition[1]">
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:assert test="$Year='true'">GPM_ChecksForSeriesInfoFilesReg.schh #22: The edition name must contain '2020'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/GPM/Identification_Information[1]/Time_Period_of_Content[1]">
            <sch:assert test="count(./Range_of_Dates[1])=1">GPM_ChecksForSeriesInfoFilesReg.schh #23: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./Range_of_Dates[1]/Beginning_Date[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./Range_of_Dates[1]/Ending_Date[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">GPM_ChecksForSeriesInfoFilesReg.schh #24: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">GPM_ChecksForSeriesInfoFilesReg.schh #25: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBox'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="/GPM/Identification_Information[1]/Spatial_Domain[1]/Bounding_Coordinates[1]">      
            <sch:assert test="not(./West_Bounding_Coordinate &lt; -180)">GPM_ChecksForSeriesInfoFilesReg.schh #26: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./West_Bounding_Coordinate &gt; 180)">GPM_ChecksForSeriesInfoFilesReg.schh #27: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_ChecksForSeriesInfoFilesReg.schh #28: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_ChecksForSeriesInfoFilesReg.schh #29: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &lt; -90)">GPM_ChecksForSeriesInfoFilesReg.schh #30: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &gt; 90)">GPM_ChecksForSeriesInfoFilesReg.schh #31:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &lt; -90)">GPM_ChecksForSeriesInfoFilesReg.schh #33: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &gt; 90)">GPM_ChecksForSeriesInfoFilesReg.schh #34:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='otherRestrictionInMD_LegalConstraints'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//Constraints[1]">
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Access_Constraints[1]='otherRestrictions' and not(Other_Constraints)">GPM_ChecksForSeriesInfoFilesReg.schh #35: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Use_Constraints[2]='otherRestrictions' and not(Other_Constraints)">GPM_ChecksForSeriesInfoFilesReg.schh #36: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">GPM_ChecksForSeriesInfoFilesReg.sch #37: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>  
    
    
    <sch:pattern id="scopeCheck">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Hierarchy_Level[1]">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='series'">GPM_ChecksForSeriesInfoFilesReg.sch #38: The hierarchy level must be 'series' </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
   <sch:pattern id='URLConsistencyCheck'>
       <sch:rule context="/GPM">
           <sch:assert test="$OnlineLinkageTheme =$NetResNameTheme">GPM_ChecksForSeriesInfoFilesReg.sch #39: The OnlineLinkage (<sch:value-of select="$OnlineLinkageTheme"/>) does not equal the network resource name (<sch:value-of select="$NetResNameTheme"/>) </sch:assert>
           <sch:assert test="$NetResNameTheme2=$MetFileId5">GPM_ChecksForSeriesInfoFilesReg.sch #40: The network resource name (<sch:value-of select="$NetResNameTheme2"/>) does not equal the metadateFile Id (<sch:value-of select="$MetFileId5"/>)</sch:assert>
       </sch:rule>
   </sch:pattern>
    
    <sch:pattern id="EAURLCheck">
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[2]/Network_Address[1]/Network_Resource_Name[1]" >
            <sch:assert test="contains(.,'https://meta.geo.census.gov')">GPM_ChecksForSeriesInfoFilesReg.sch #41: The download URL for the EA file should contain 'https://meta.geo.census.gov'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ='editionCount'>
        <sch:rule context="/GPM/Identification_Information[1]">
            <sch:assert test="count(./Citation[1]/Edition[1]=1)">GPM_ChecksForSeriesInfoFilesReg.sch #42: There must at least one edition</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='EditionCheck '>
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Edition[1]" >
            
            
            <sch:assert test="$editionVer eq'FE'">GPM_ChecksForSeriesInfoFilesReg.sch #43: The edition must be '2020FE'. It is (<sch:value-of select="$editionVer"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>