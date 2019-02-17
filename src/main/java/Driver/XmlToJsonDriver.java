package Driver;

import java.io.File;

import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import conversion.XmlToJason;

public class XmlToJsonDriver
{
   private static final String seperator = File.separator;
   private static final String RESOURCE_PATH = "src" + seperator + "main" + seperator + "resources" + seperator;
   private static String XSLT = RESOURCE_PATH + "XmlPatientToJasonPatient.xsl";
   private static String JASON_OUTPUT_FILE = RESOURCE_PATH + "jason";

   private static String INPUT_FILE = RESOURCE_PATH + "data.xml";

   public static void main(String[] args) throws Exception
   {
      StreamSource xsltStream = new StreamSource(new File(XSLT));
      StreamSource inputFileStream = new StreamSource(new File(INPUT_FILE));
      StreamResult outputStream = new StreamResult(new File(JASON_OUTPUT_FILE));

      XmlToJason convertXmlToJson = new XmlToJason(xsltStream,inputFileStream, outputStream);
      convertXmlToJson.convert();
   }
}
