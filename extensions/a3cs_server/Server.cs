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
        private static readonly string API_KEY = "1234";

        private static readonly string[] simpleEvents = { "srvPreStart", "srvPreInit", "srvPostInit" };
        private static readonly string[] sourceEvents = { "userFAKSelf", "userFAKAI", "userStitchAI", "userStitchSelf", "userUncon", "userWakeUp" };
        private static readonly string[] valueEvents = { "msStart", "msEnd", "srvStChanged" };
        private static readonly string[] sourceValueEvents = { "userFAK", "userStitch", "userNetConn", "userNetDisconn", "userDigTrench", "userGrenThrow" };
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

            if (sourceEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (valueEvents.Contains(function))
            {
                data.Add("v", args[0].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceBodyMedEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("bp", args[1].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueBodyMedEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("bp", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceValueBodyMedTypeEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("t", args[2].Trim('"'));
                data.Add("bp", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (sourceBodyMedTypeEvents.Contains(function))
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("t", args[1].Trim('"'));
                data.Add("bp", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userFF")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("a", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCPR")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("ef", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCPRAI")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("ef", args[1].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCheckHR" || function == "userCheckBP")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("bp", args[2].Trim('"'));
                data.Add("vl", args[3].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userCheckHRAI" || function == "userCheckHRSelf" || function == "userCheckBPAI" || function == "userCheckBPSelf")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("bp", args[1].Trim('"'));
                data.Add("vl", args[2].Trim('"'));

                HTTPRequest(function, data);
                output.Append("true");
                return 0;
            }

            if (function == "userDead")
            {
                data.Add("s", args[0].Trim('"'));
                data.Add("v", args[1].Trim('"'));
                data.Add("li", args[2].Trim('"'));

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