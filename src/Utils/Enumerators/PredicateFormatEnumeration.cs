namespace Utils.Enumerators
{
    public enum Operation
    {
        Equals = 1,
        Contains = 2,
        StartsWith = 3,
        EndsWith = 4,
        NotEquals = 5,
        GreaterThan = 6,
        GreaterThanOrEquals = 7,
        LessThan = 8,
        LessThanOrEquals = 9,
        DoesNotContain = 10,
        IsNull = 11,
        IsNotNull = 12,
        IsEmpty = 13,
        IsNotEmpty = 14
    }
    public enum Operator
    {
        And = 0,
        Or = 1
    }

    public enum OrderByDirection
    {
        ASC = 1,
        DESC = 2
    }


}
