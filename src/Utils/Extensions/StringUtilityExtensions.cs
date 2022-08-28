using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils.Constants;

namespace Utils.Extensions
{
    public static class StringUtilityExtensions
    {
        /// <summary>
        /// Get the civility from the gender by language
        /// </summary>
        /// <param name="language"></param>
        /// <param name="gender"></param>
        /// <returns></returns>
        public static string GetTheCurrentLanguageCivilityFromGender(this string language, int gender)
        {
            string civility;
            if (language == "fr")
            {
                if (gender == 1)
                {
                    civility = "Monsieur";
                }
                else
                {
                    civility = "Madame";
                }
            }
            else
            {
                if (gender == 1)
                {
                    civility = "Mister";
                }
                else
                {
                    civility = "Mrs";
                }
            }
            return civility;
        }
        
        public static string GeneratePassword()
        {
            string[] randomChars = new[] {
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ",               // uppercase 
                "abcdefghijklmnopqrstuvwxyz",               // lowercase
                "0123456789",                               // digits
                "{[(!+%,^$?_-*;:.°'#|~&`=/)]}"              // non-alphanumeric !!!!don't use "<" or ">" to not confuse with html tags 
                                                            // and don't use "@" to not confuse with email link!!!!
                };
            Random rand = new Random(Environment.TickCount);
            List<char> chars = new List<char>();

            chars.Insert(rand.Next(0, chars.Count),
                    randomChars[0][rand.Next(0, randomChars[0].Length)]);

            chars.Insert(rand.Next(0, chars.Count),
                    randomChars[1][rand.Next(0, randomChars[1].Length)]);

            chars.Insert(rand.Next(0, chars.Count),
                    randomChars[2][rand.Next(0, randomChars[2].Length)]);


            chars.Insert(rand.Next(0, chars.Count),
                    randomChars[3][rand.Next(0, randomChars[3].Length)]);


            for (int i = chars.Count; i < NumberConstant.SharedDocumentsKeyLenght
                || chars.Distinct().Count() < NumberConstant.SharedDocumentsKeyLenght / 2; i++)
            {
                string rcs = randomChars[rand.Next(0, randomChars.Length)];
                chars.Insert(rand.Next(0, chars.Count),
                    rcs[rand.Next(0, rcs.Length)]);
            }

            return new string(chars.ToArray());
        }
        /// <summary>
        /// Get the Gender Name from the gender id by language
        /// </summary>
        /// <param name="language"></param>
        /// <param name="gender"></param>
        /// <returns></returns>
        public static string GetTheCurrentGenderNameFromGenderId(this string language, int gender)
        {
            string GenderName;
            if (language == "fr")
            {
                if (gender == 1)
                {
                    GenderName = "Homme";
                }
                else if (gender == 2)
                {
                    GenderName = "Femme";
                }
                 else
                {
                    GenderName = "H/F";

                }
            }
            else
            {
                if (gender == 1)
                {
                    GenderName = "Male";
                }
                else if(gender == 2)
                {
                    GenderName = "Female";
                }
                else
                {
                    GenderName = "H/F";

                }
            }
            return GenderName;
        }

        public static string DecodeLicense(this string text)
        {
            text = text.Replace('_', '/').Replace('-', '+');
            switch (text.Length % 4)
            {
                case 2:
                    text += "==";
                    break;
                case 3:
                    text += "=";
                    break;
            }
            return Encoding.UTF8.GetString(Convert.FromBase64String(text));
        }


        public static string ConcatListElements(this List<string> list, string separator)
        {
            string toReturn = "";
            if (list.Any())
            {
                toReturn = list.First();
            }
            list.Skip(1).ToList().ForEach(element =>
            {
                toReturn += separator + element;
            });
            return toReturn;
        }
    }
}
