<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmx" prefix="gmx"/>
    <sch:ns uri="http://www.isotc211.org/2005/gfc" prefix="gfc"/>
  
    <sch:pattern id="dateCheck">
        <sch:title>Date check</sch:title>
        <sch:rule context="//gco:Date">
            <sch:report test="string-length(.) != 7">Date format must be YYYY-MM (7 characters) (date test)</sch:report>
            
           <!--  <sch:assert test="contains(.,'2019'">The year must be 2019 CCCCCCCC</sch:assert> -->
           </sch:rule>
    </sch:pattern>
    
    <!--  
         <sch:report test="substring(.,0,4)!= '2019' "> The year must be 2019</sch:report>
            <sch:report test="contains(.,'2019')">The year must be 2019</sch:report>
            <sch:let name="Date" value="substring(.,0,4)"/>
            <sch:report test="contains($Date,'2019')"></sch:report>
           <sch:assert test="Date>2018">The year must be 2019aaaaa</sch:assert>
      
        
        <pattern>
        <title>gco:Date</title>
         <rule context="/gfc:FC_FeatureCatalogue/gmx:versionDate/gco:Date">
            <report test="string-length(.) != 7">Date format must be YYYY-MM (7 characters) (date test)</report>      
        </rule>
    </pattern>  
    
    
    
    <sch:pattern id="DateCheck">
       <sch:rule context="substring(/gfc:FC_FeatureCatalogue/gmx:versionDate[1])">
           <sch:assert test="matches(./gco:Date,'2018')">The year must be 2018</sch:assert>
       </sch:rule>
       
   </sch:pattern>
    
   
    
  <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">The codelist value must be equal to 'UTF-8'</sch:assert>
            <sch:assert test="contains(./@codeSpace,'004')">The codespace value for gmd:MD_CharacterSetCode must be '004' </sch:assert>
        </sch:rule>
    </sch:pattern>--> 
    
    
</sch:schema>