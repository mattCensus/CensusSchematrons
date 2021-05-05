<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
   
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi" />
    <sch:ns prefix="gmd"  uri="http://www.isotc211.org/2005/gmd" />
    <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
    <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <sch:ns prefix="gts" uri="http://www.isotc211.org/2005/gts"/>
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
   
    <sch:let name="KMLKeyword" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'KML')"/>
    <sch:let name="SHPKeyword" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'Shapefile')"/>
    <sch:let name="GDBKeyword" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'Geodatabase')"/>
    
    <sch:let name="KMLTitle" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'KML')"/>
    <sch:let name="SHPTitle" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'Shapefile')"/>
    <sch:let name="GDBTitle" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'Geodatabase')"/>
    
    <sch:let name="KMLAB" value="contains(//gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:abstract[1]/gco:CharacterString[1],'KML')"/>
    <sch:let name="ShpAB" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:abstract[1]/gco:CharacterString[1],'shapefiles')"/>
    <sch:let name="GDBAB" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:abstract[1]/gco:CharacterString[1],'geodatabase')"/>
    
    <sch:let name="KMLFileId" value="contains(/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1],'kml')"/>
    <sch:let name="ShpFileId" value="contains(/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1],'shp')"/>
    <sch:let name="gdbFileId" value="contains(/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1],'gdb')"/>
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="contains(.,'2021')">ISO_NewStdCartSchematron.sch:ERR #1A: The year mustbe 2020.</sch:assert>
            <sch:assert test="contains(.,'03')">ISO_NewStdCartSchematron.sch:ERR #1B: The month must be 08 and the day must be 25.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:assert test="contains(.,'https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html')">ISO_NewStdCartSchematron.sch ERR #2: The online linkage must be https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!--                                                                                           gmd:descriptiveKeywords[2] change this one                     -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1]">
          <!--   <sch:assert test="$KMLKeyword =false and $SHPKeyword=false" >The keywords must contain either SHP or KML KMLKeyword:<sch:value-of select="$KMLKeyword"/> Shapekeyword:<sch:value-of select="$SHPKeyword"/></sch:assert>
     <sch:assert test="$KMLKeyword = $KMLTitle"> Both the title and the keywords must have KML Title<sch:value-of select="$KMLTitle"/> keyword:<sch:value-of select="$KMLKeyword"/></sch:assert>   -->
            <sch:assert test="contains(.,'SHP') or contains(.,'KML') or contains(.,'Geodatabase')">ISO_NewStdCartSchematron.sch ERR #3: The Keywords must contain either Shapefile<sch:value-of select="$SHPTitle"/>, KML<sch:value-of select="$KMLTitle"/> or goedatabase <sch:value-of select="$GDBKeyword"/></sch:assert>
        </sch:rule>
        
    
    </sch:pattern>
    
   <sch:pattern>
       <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1]">
           <sch:assert test="contains(.,'Shapefile') or contains(.,'KML')  or contains(.,'Geodatabase')">ISO_NewStdCartSchematron.sch ERR #4: The Title must contain either Shapefile:<sch:value-of select="$SHPTitle"/>, KML:<sch:value-of select="$KMLTitle"/> or Geodatabase <sch:value-of select="$GDBTitle"/> </sch:assert>
       </sch:rule>
   </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[2]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:assert test="contains(.,'https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html')">ISO_NewStdCartSchematron.sch ERR #5: The URL must be https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">ISO_NewStdCartSchematron.sch ERR #6: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">ISO_NewStdCartSchematron.sch ERR #7: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_NewStdCartSchematron.sch ERR #8: eastBoundLongitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_NewStdCartSchematron.sch ERR #9: eastBoundLongitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">ISO_NewStdCartSchematron.sch ERR #10: southBoundLatitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">ISO_NewStdCartSchematron.sch ERR #11: southBoundLatitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">ISO_NewStdCartSchematron.sch ERR #12: northBoundLatitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">ISO_NewStdCartSchematron.sch ERR #13: northBoundLatitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata">
            <sch:let name="Keyword" value="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1]"/>
            <sch:assert test="$KMLKeyword = $KMLTitle">ISO_NewStdCartSchematron.sch ERR #14: The title (<sch:value-of select="$KMLTitle"/>  keywords (<sch:value-of select="$KMLKeyword"/>) do not match </sch:assert>
            <sch:assert test="$KMLKeyword = $KMLAB">ISO_NewStdCartSchematron.sch ERR #15: The Keyword (<sch:value-of select="$KMLKeyword"/> and the abstract <sch:value-of select="$KMLAB"/> bosth must contain 'KML' "</sch:assert>
            <sch:assert test="$KMLKeyword = $KMLFileId">ISO_NewStdCartSchematron.sch ERR #15-1: The Keyword (<sch:value-of select="$KMLKeyword"/> and the file id <sch:value-of select="$KMLFileId"/> shold both contain 'KML'</sch:assert>
            
            <sch:assert test="$SHPKeyword = $SHPTitle"> ISO_NewStdCartSchematron.sch ERR #16:The Keyword (<sch:value-of select="$SHPKeyword" /> and the the Title (<sch:value-of select="$SHPTitle"/> must both contain "Shapefile"</sch:assert>
            <sch:assert test="$SHPKeyword = $ShpAB" >ISO_NewStdCartSchematron.sch ERR #17: The Keyword (<sch:value-of select="$SHPKeyword"/>) and the abstract (<sch:value-of select="$ShpAB"/>) must both contain "Shapefile"  </sch:assert>
            <sch:assert test="$SHPKeyword = $ShpFileId">ISO_NewStdCartSchematron.sch ERR #17: The Keyword (<sch:value-of select="$SHPKeyword"/>) and the File id <sch:value-of select="$ShpFileId"/> must both contain 'shp' </sch:assert>
            
            <sch:assert test="$GDBKeyword = $GDBTitle">ISO_NewStdCartSchematron.sch ERR #18: The keyword (<sch:value-of select="$GDBKeyword"/>) and the title (<sch:value-of select="$GDBTitle"/>) must both contain "Geodatabase</sch:assert>
            <sch:assert test="$GDBKeyword = $GDBAB">ISO_NewStdCartSchematron.sch ERR #19: The keyword (<sch:value-of select="$GDBKeyword"/>) and the abstract must (<sch:value-of select="$GDBAB"/>)  both contain "Geodatabase"</sch:assert>
            <sch:assert test="$GDBKeyword = $gdbFileId">ISO_NewStdCartSchematron.sch ERR #19: The keyword (<sch:value-of select="$GDBKeyword"/>) and the fileid must both contain "gdb' (<sch:value-of select="$gdbFileId"/>)</sch:assert>
            
        </sch:rule>
    </sch:pattern>
</sch:schema>