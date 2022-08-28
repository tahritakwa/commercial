using System;
using System.Security.Cryptography;
using System.Text;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
        where TModel : class
        where TEntity : class
    {
        /// <summary>
        /// Hash an input string and return the hash as
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static string GetSHA512Hash(string input)
        {
            // Initialize a SHA256 hash object.
            SHA512 SHA512 = SHA512Managed.Create();
            // Convert the input string to a byte array and compute the hash.
            byte[] data = SHA512.ComputeHash(Encoding.Unicode.GetBytes(input));
            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }

        /// <summary>
        /// Verify a hash against a string.
        /// </summary>
        /// <param name="input"></param>
        /// <param name="hash"></param>
        /// <returns></returns>
        public static bool VerifySHA512Hash(string input, string hash)
        {
            // Hash the input.
            string hashOfInput = GetSHA512Hash(input);

            // Create a StringComparer an compare the hashes.
            StringComparer comparer = StringComparer.OrdinalIgnoreCase;

            if (0 == comparer.Compare(hashOfInput, hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
