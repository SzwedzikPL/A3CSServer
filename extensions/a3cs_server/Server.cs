using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Runtime.InteropServices;
using RGiesecke.DllExport;
using System.Net.Http;
using System.Net;


namespace a3cs_server
{
    public class A3CSServerExtension
    {
        private static readonly HttpClient client = new HttpClient();
        private static readonly string API_URL = "https://arma3coop.pl/arma_api.php";
        private static readonly string API_KEY = "56c72e";

        private static readonly string[] simpleEvents = { "srvPreInit", "srvPostInit" };
        private static readonly string[] sourceEvents = { "userFAKSelf", "userFAKAI", "userStitchAI", "userStitchSelf", "userUncon", "userWakeUp", "userDressSetDep", "userDressSetRem", "userAntennaDep", "userAntennaRem" };
        private static readonly string[] valueEvents = { "srvPreStart", "msStart", "msEnd", "srcSimObjSpawnS", "srcSimObjSpawnE", "curAccGrant", "curAccRev" };
        private static readonly string[] sourceValueEvents = { "userFAK", "userStitch", "userNetConn", "userNetDisconn", "userDigTrench", "userGrenThrow", "curHeal", "userExpDet", "userExpDetOnDef", "userExpDef" };
        private static readonly string[] sourceBodyMedEvents = { "userSplintSelf", "userSplintAI", "userSetTourSelf", "userSetTourAI", "userRemTourSelf", "userRemTourAI" };
        private static readonly string[] sourceValueBodyMedEvents = { "userSplint", "userSetTour", "userRemTour" };
        private static readonly string[] sourceBodyMedTypeEvents = {"userMedSelf", "userMedAI", "userBandSelf", "userBandAI", "userIVSelf", "userIVAI" };
        private static readonly string[] sourceValueBodyMedTypeEvents = { "userBand", "userMed", "userIV" };

        [DllExport("RVExtensionVersion", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtensionVersion(StringBuilder output, int outputSize)
        {
            output.Append("A3CSServerExtension v1.0.0");
            return;
        }

        [DllExport("RVExtension", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtension(StringBuilder output, int outputSize,
            [MarshalAs(UnmanagedType.LPStr)] string function)
        {

            if (function == "init")
            {
                output.Append("true");
                return;
            }
            
            if (simpleEvents.Contains(function))
            {
                Dictionary<string, string> data = new Dictionary<string, string> {};
                HTTPRequest(function, data);
                output.Append("true");
                return;
            }

            output.Append("false");
            return;
        }

        [DllExport("RVExtensionArgs", CallingConvention = CallingConvention.Winapi)]
        public static int RvExtensionArgs(StringBuilder output, int outputSize,
            [MarshalAs(UnmanagedType.LPStr)] string function,
            [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.LPStr, SizeParamIndex = 4)] string[] args, int argCount)
        {
            Dictionary<string, string> data = new Dictionary<string, string> { };

            if (function == "srvPreStart" || function == "srvStChanged")
            {
                data.Add("v", args[0].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (valueEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceBodyMedEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("bp", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueBodyMedEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("bp", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueBodyMedTypeEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("t", args[3].Trim('"'));
                data.Add("bp", args[4].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceBodyMedTypeEvents.Contains(function))
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("t", args[2].Trim('"'));
                data.Add("bp", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userFF")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("a", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCPR")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("ef", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCPRAI")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("ef", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCheckHR" || function == "userCheckBP")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("bp", args[3].Trim('"'));
                data.Add("vl", args[4].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCheckHRAI" || function == "userCheckHRSelf" || function == "userCheckBPAI" || function == "userCheckBPSelf")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("bp", args[2].Trim('"'));
                data.Add("vl", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userDead")
            {
                data.Add("mt", args[0].Trim('"'));
                data.Add("s", args[1].Trim('"'));
                data.Add("v", args[2].Trim('"'));
                data.Add("li", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "curModCreat")
            {
                data.Add("mt", args[0].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }
            

            if (function == "userEndStats")
            {
                data.Add("nm", args[0].Trim('"'));
                data.Add("uid", args[1].Trim('"'));
                data.Add("ms", args[2].Trim('"'));
                data.Add("tp", args[3].Trim('"'));
                data.Add("dt", args[4].Trim('"'));
                data.Add("bl", args[5].Trim('"'));
                data.Add("gr", args[6].Trim('"'));
                data.Add("kb", args[7].Trim('"'));
                data.Add("ko", args[8].Trim('"'));
                data.Add("ki", args[9].Trim('"'));
                data.Add("kc", args[10].Trim('"'));
                data.Add("un", args[11].Trim('"'));
                data.Add("de", args[12].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "srvTelemetry")
            {
                data.Add("mn", args[0].Trim('"'));
                data.Add("mt", args[1].Trim('"'));
                data.Add("fps", args[2].Trim('"'));
                data.Add("fpsm", args[3].Trim('"'));
                data.Add("pc", args[4].Trim('"'));
                data.Add("apc", args[5].Trim('"'));
                data.Add("gb", args[6].Trim('"'));
                data.Add("go", args[7].Trim('"'));
                data.Add("gi", args[8].Trim('"'));
                data.Add("gc", args[9].Trim('"'));
                data.Add("ai", args[10].Trim('"'));
                data.Add("aisrv", args[11].Trim('"'));
                data.Add("ais", args[12].Trim('"'));
                data.Add("ains", args[13].Trim('"'));
                data.Add("vc", args[14].Trim('"'));
                data.Add("vsrv", args[15].Trim('"'));
                data.Add("vsc", args[16].Trim('"'));
                data.Add("vnsc", args[17].Trim('"'));
                data.Add("oc", args[18].Trim('"'));
                data.Add("cc", args[19].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }
                

            output.Append("false");
            return 1;
        }

        private static async void HTTPRequest(string type, Dictionary<string, string> data)
        {
            try
            {
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

                data.Add("key", API_KEY);
                data.Add("type", type);

                long unixTimestamp = (int)System.DateTime.UtcNow.Subtract(new System.DateTime(1970, 1, 1)).TotalSeconds;
                data.Add("date", unixTimestamp.ToString());

                FormUrlEncodedContent content = new FormUrlEncodedContent(data);
                _ = await client.PostAsync(API_URL, content);
            }
            catch
            {

            }

            return;
        }

    }
}