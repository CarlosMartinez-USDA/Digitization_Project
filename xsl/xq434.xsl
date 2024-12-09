<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">
  <xsl:output method="text"/>
<?startSampleFile ?>
<!-- xq434.xsl: converts xq423.xml into xq435.xml -->

<xsl:template match="employees">
  <xsl:apply-templates>
    <xsl:sort select="substring(@hireDate,7,4)"/> <!-- year  -->
    <xsl:sort select="substring(@hireDate,1,2)"/> <!-- month -->
    <xsl:sort select="substring(@hireDate,3,2)"/> <!-- day   -->
  </xsl:apply-templates>
</xsl:template>
<?endSampleFile ?>

<xsl:template match="employee">
  Last:      <xsl:apply-templates select="last"/>
  First:     <xsl:apply-templates select="first"/>
  Salary:    <xsl:apply-templates select="salary"/>
  Hire Date: <xsl:apply-templates select="@hireDate"/>
  <xsl:text>
</xsl:text>

</xsl:template>

</xsl:stylesheet>


