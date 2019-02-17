<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"  xmlns:xslFunctions="my functions"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xsl:import href="translationMaps.xsl"/>
<xsl:output method="text"/>
	
<xsl:template match="/">[
<xsl:apply-templates select="*"/>]
</xsl:template>

<xsl:template match="patients/patient">
	{
 		"patientId" : <xsl:value-of select="id"></xsl:value-of>,
 		"sex": "<xsl:value-of select="xslFunctions:getPatientSex(gender)"></xsl:value-of>",
 		"state": <xsl:value-of select="xslFunctions:getAbbreviated(state)"></xsl:value-of>,
 		"name": "<xsl:value-of select="name"></xsl:value-of>",
 		"age": <xsl:value-of select="xslFunctions:calculateAge(dob)"></xsl:value-of>
 	}
   <xsl:if test="following-sibling::*">,</xsl:if>
</xsl:template>

	<!-- This function calculates age from date of birth.-->
<xsl:function name="xslFunctions:calculateAge" as="xs:integer" >
    <xsl:param name="dateOfBirth"/>
    <xsl:variable name="Birthday"  select="xs:date(replace($dateOfBirth, '(\d{2})/(\d{2})/(\d{4})', '$3-$1-$2'))"/>
	<xsl:variable name="personAge">
		<xsl:choose>
			<xsl:when
				test="month-from-date(current-date()) > month-from-date($Birthday) or month-from-date(current-date()) = month-from-date($Birthday) and day-from-date(current-date()) >= day-from-date($Birthday)">
				<xsl:value-of
					select="year-from-date(current-date()) - year-from-date($Birthday)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="year-from-date(current-date()) - year-from-date($Birthday) - 1" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
    <xsl:value-of select="$personAge"/>
  </xsl:function>
  
  	<!-- It uses map from transalationMap xsl to get abbreviated America state.-->
  <xsl:function name="xslFunctions:getAbbreviated" as="xs:string" >
    <xsl:param name="State"/>
     <xsl:variable name="abState" select=
  "concat(upper-case(substring($State,1,1)),
          lower-case(substring($State, 2)),
          ' '[not(last())]
         )
  "/>
    <xsl:value-of select="$stateMap/entry[@key=$abState]"/>
  </xsl:function>

  	<!-- It uses map from transalationMap xsl to get gender m/f values.-->
<xsl:function name="xslFunctions:getPatientSex" as="xs:string" >
    <xsl:param name="gender"/>
     <xsl:variable name="sex" select=
  "(upper-case(substring($gender,1,1)),
          ''[not(last())]
         )
  "/>
    <xsl:value-of select="$genderMap/entry[@key=$sex]"/>
  </xsl:function>
</xsl:stylesheet>