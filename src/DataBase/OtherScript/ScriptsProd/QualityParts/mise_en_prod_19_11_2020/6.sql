/*
Ce script a été créé par Visual Studio dans 16/10/2020 à 14:54.
Exécutez ce script sur ..QualityParts (dev) pour le rendre identique à ..MasterGuidTN (dev).
Ce script effectue ses actions dans l'ordre suivant :
1. Désactive les contraintes de clé étrangère.
2. Effectue des commandes DELETE. 
3. Effectue des commandes UPDATE.
4. Effectue des commandes INSERT.
5. Réactive les contraintes de clé étrangère.
Sauvegardez votre base de données cible avant d'exécuter ce script.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointeur utilisé pour les mises à jour de texte ou d'image. Cela n'est peut-être pas nécessaire, mais est déclaré ici le cas échéant*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_Module]
ALTER TABLE [ERPSettings].[ModuleConfig] DROP CONSTRAINT [FK_ModuleConfig_RoleConfig]
ALTER TABLE [ERPSettings].[Module] DROP CONSTRAINT [FK_Module_Module]
ALTER TABLE [ERPSettings].[ReportTemplate] DROP CONSTRAINT [FK_ReportTemplate_Entity]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Information]
ALTER TABLE [ERPSettings].[Information] DROP CONSTRAINT [FK_Information_Functionality]
ALTER TABLE [ERPSettings].[RoleConfig] DROP CONSTRAINT [FK_RoleConfigCategory_RoleConfig]
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2770
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2771
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2772
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2773
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2774
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2775
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2776
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2777
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2778
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2779
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2780
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2781
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2782
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2783
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2784
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2785
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2786
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2787
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2788
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2789
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2790
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2791
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2792
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2793
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2794
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2795
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2796
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2797
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2798
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2799
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2800
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2801
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2802
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2803
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2804
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2805
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2806
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2807
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2808
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2809
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2810
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2811
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2812
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2813
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2814
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2815
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2816
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2817
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2818
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2819
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2820
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2821
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2822
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2823
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2824
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2825
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2826
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2827
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2828
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2829
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2830
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2831
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2832
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2833
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2834
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2835
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2836
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2837
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2838
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2839
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2840
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2841
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2842
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2843
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2844
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2845
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2846
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2847
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2848
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2849
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2850
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2851
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2852
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2853
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2854
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2855
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2856
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2857
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2858
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2859
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2860
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2861
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2862
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2863
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2864
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2865
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2866
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2867
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2868
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2869
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2870
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2871
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2872
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2873
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2874
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2875
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2876
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2877
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2878
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2879
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2880
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2881
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2882
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2883
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2884
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2885
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2886
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2887
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2888
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2889
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2890
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2891
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2892
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2893
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2894
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2895
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2896
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2897
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2898
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2899
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2900
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2901
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2902
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2903
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2904
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2905
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2906
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2907
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2908
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2909
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2910
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2911
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2912
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2913
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2914
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2915
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2916
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2917
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2918
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2919
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2920
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2921
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2922
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2923
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2924
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2925
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2926
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2927
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2928
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2929
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2930
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2931
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2932
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2933
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2934
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2935
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2936
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2937
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2938
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2939
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2940
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2941
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2942
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2943
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2944
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2945
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2946
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2947
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2948
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2949
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2950
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2951
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2952
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2953
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2954
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2955
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2956
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2957
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2958
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2959
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2960
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2961
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2962
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2963
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2964
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2965
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2966
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2967
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2968
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2969
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2970
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2971
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2972
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2973
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2974
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2975
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2976
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2977
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2978
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2979
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2980
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2981
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2982
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2985
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2986
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2987
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2988
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2989
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2990
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2991
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2992
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2993
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2994
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2995
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2996
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2997
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2998
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=2999
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3000
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3001
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3002
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3003
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3004
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3005
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3006
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3007
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3008
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3009
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3010
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3011
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3012
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3013
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3014
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3015
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3016
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3017
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3018
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3019
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3020
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3021
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3022
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3023
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3024
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3025
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3026
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3027
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3028
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3029
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3030
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3031
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3032
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3033
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3034
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3035
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3036
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3037
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3038
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3039
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3040
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3041
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3042
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3043
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3044
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3045
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3046
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3047
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3048
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3049
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3050
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3051
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3052
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3053
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3054
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3055
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3056
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3057
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3058
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3059
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3060
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3061
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3062
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3063
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3064
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3065
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3066
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3067
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3068
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3069
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3070
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3071
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3072
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3073
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3074
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3075
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3076
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3077
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3078
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3079
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3080
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3081
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3082
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3083
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3084
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3085
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3086
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3087
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3088
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3089
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3090
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3091
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3092
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3093
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3094
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3095
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3096
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3097
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3098
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3099
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3100
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3101
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3102
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3103
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3104
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3105
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3106
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3107
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3108
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3109
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3110
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3111
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3112
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3113
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3114
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3115
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3116
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3117
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3118
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3119
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3120
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3121
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3122
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3123
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3124
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3125
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3126
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3127
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3128
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3129
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3130
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3131
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3132
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3133
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3134
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3135
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3136
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3137
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3138
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3139
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3140
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3141
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3142
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3143
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3144
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3145
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3146
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3147
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3148
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3149
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3150
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3151
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3152
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3153
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3154
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3155
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3156
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3157
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3158
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3159
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3160
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3161
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3162
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3163
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3164
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3165
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3166
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3167
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3168
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3169
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3170
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3171
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3172
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3173
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3174
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3175
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3176
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3177
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3178
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3179
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3180
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3181
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3182
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3183
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3184
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3185
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3186
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3187
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3188
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3189
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3190
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3191
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3192
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3193
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3194
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3195
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3196
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3197
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3198
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3199
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3200
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3201
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3202
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3203
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3204
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3205
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3206
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3207
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3208
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3209
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3210
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3211
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3212
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3213
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3214
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3215
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3216
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3217
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3218
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3219
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3220
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3221
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3222
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3223
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3224
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3225
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3226
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3227
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3228
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3229
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3230
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3231
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3232
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3233
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3234
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3235
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3236
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3237
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3238
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3239
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3240
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3241
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3242
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3243
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3244
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3245
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3246
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3247
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3248
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3249
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3250
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3251
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3252
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3253
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3254
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3255
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3256
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3257
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3258
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3259
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3260
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3261
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3262
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3263
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3264
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3265
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3266
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3267
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3268
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3269
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3270
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3271
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3272
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3273
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3274
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3275
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3276
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3277
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3278
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3279
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3280
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3281
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3282
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3283
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3284
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3285
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3286
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3287
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3288
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3289
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3290
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3291
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3292
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3293
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3294
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3295
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3296
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3297
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3298
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3299
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3300
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3301
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3302
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3303
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3304
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3305
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3306
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3307
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3308
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3309
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3310
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3311
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3312
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3313
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3314
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3315
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3316
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3317
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3318
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3319
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3320
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3321
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3322
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3323
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3324
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3325
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3326
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3327
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3328
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3329
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3330
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3331
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3332
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3333
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3334
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3335
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3336
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3337
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3338
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3339
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3340
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3341
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3342
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3343
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3344
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3345
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3346
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3347
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3348
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3349
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3350
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3351
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3352
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3353
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3354
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3355
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3356
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3357
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3358
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3359
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3360
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3361
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3362
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3363
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3364
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3365
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3366
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3367
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3368
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3369
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3370
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3371
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3372
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3373
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3374
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3375
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3376
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3377
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3378
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3379
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3380
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3381
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3382
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3383
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3384
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3385
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3386
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3387
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3388
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3389
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3390
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3391
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3392
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3393
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3394
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3395
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3396
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3397
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3398
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3399
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3400
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3401
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3402
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3403
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3404
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3405
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3406
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3407
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3408
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3409
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3410
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3411
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3412
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3413
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3414
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3415
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3416
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3417
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3418
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3419
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3420
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3421
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3422
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3423
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3424
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3425
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3426
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3427
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3428
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3429
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3430
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3431
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3432
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3433
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3434
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3435
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3436
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3437
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3438
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3439
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3440
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3441
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3442
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3443
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3444
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3445
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3446
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3447
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3448
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3449
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3450
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3451
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3452
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3453
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3454
DELETE FROM [ERPSettings].[ModuleConfig] WHERE [Id]=3455
DELETE FROM [ERPSettings].[Module] WHERE [IdModule]=N'51bf3865-133e-4e97-9f99-14564644125d'
DELETE FROM [ERPSettings].[ReportTemplate] WHERE [Id]=18
DELETE FROM [ERPSettings].[ReportTemplate] WHERE [Id]=19
DELETE FROM [ERPSettings].[ReportTemplate] WHERE [Id]=20
DELETE FROM [ERPSettings].[ReportTemplate] WHERE [Id]=21
UPDATE [ERPSettings].[RoleConfigCategory] SET [Label]=N'Reglages' WHERE [Id]=77777
UPDATE [ERPSettings].[RoleConfigCategory] SET [Label]=N'Correction du stock' WHERE [Id]=100100
UPDATE [ERPSettings].[ReportTemplate] SET [IdEntity]=NULL, [TemplateCode]=NULL, [TemplateNameFr]=N'purchasedeliveryreport_fr', [TemplateNameEn]=N'purchasedeliveryreport_en', [ReportCode]=N'D-PU', [ReportName]=N'purchasedeliveryreport' WHERE [Id]=5
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'I-SA' WHERE [Id]=6
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'I-PU' WHERE [Id]=7
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'Q-SA' WHERE [Id]=8
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'genericDocumentReport_fr', [TemplateNameEn]=N'genericDocumentReport_en', [ReportCode]=N'Q-PU', [ReportName]=N'genericDocumentReport' WHERE [Id]=9
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'A-SA' WHERE [Id]=10
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'A-PU' WHERE [Id]=11
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'RQ-PU' WHERE [Id]=12
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'B-PU' WHERE [Id]=13
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'FO-PU' WHERE [Id]=14
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'report_be_bs_fr', [TemplateNameEn]=N'report_be_bs_en', [ReportCode]=N'BE-PU', [ReportName]=N'report_be_bs' WHERE [Id]=15
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'report_be_bs_fr', [TemplateNameEn]=N'report_be_bs_en', [ReportCode]=N'BS-SA', [ReportName]=N'report_be_bs' WHERE [Id]=16
UPDATE [ERPSettings].[ReportTemplate] SET [ReportCode]=N'IA-SA' WHERE [Id]=17
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500009
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500010
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500011
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500012
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500013
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500014
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500015
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500016
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500017
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500018
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500019
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500020
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500022
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500023
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500024
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500025
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500026
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500029
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500033
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500035
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500039
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500041
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500043
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500045
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500047
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500048
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500050
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500052
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500054
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500056
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500060
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500065
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000500066
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501065
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501066
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501067
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501068
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501071
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501072
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501075
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501076
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté une demande de congé {DOC_CODE} pour {PROFIL}', [EN]=N'{DOC_CREATOR} added a new leave request {DOC_CODE} for {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501081
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501082
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a ajouté une demande de document {DOC_CODE} pour {PROFIL}', [EN]=N'{DOC_CREATOR} added a new document request {DOC_CODE} for {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501083
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} updated the leave request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501084
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501085
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a modifié la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} updated the document request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501086
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} validated the leave request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501087
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501088
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a validé la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} validated the document request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501089
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} refused the leave request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501090
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501091
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a refusé la demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} refused the document request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501092
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a annulé la demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} canceled the leave request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501093
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de congé {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} removed the leave request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501094
UPDATE [ERPSettings].[Information] SET [EN]=N'{DOC_CREATOR} removed the expense report {DOC_CODE} {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501095
UPDATE [ERPSettings].[Information] SET [FR]=N'{DOC_CREATOR} a supprimé une demande de document {DOC_CODE} de {PROFIL}', [EN]=N'{DOC_CREATOR} removed the document request {DOC_CODE} of {PROFIL}', [IsMail]=1 WHERE [IdInfo]=1000501096
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501195
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501196
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501197
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501198
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501199
UPDATE [ERPSettings].[Information] SET [IsMail]=1 WHERE [IdInfo]=1000501200
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=0 WHERE [Id]=22222
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=0 WHERE [Id]=33333
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=0 WHERE [Id]=44444
UPDATE [ERPSettings].[RoleConfig] SET [IsDeleted]=0 WHERE [Id]=100008
UPDATE [ERPSettings].[RoleConfig] SET [RoleName]=N'État de Contrôle                                  ' WHERE [Id]=100058
GO
SET IDENTITY_INSERT [ERPSettings].[Information] ON
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501202, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501204, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a validé le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} validated the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATION_TIMESHEET', N'VALIDATION_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501207, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/review', N' votre entretien annuel sera dans {REVIEW_DAYS_NUMBER} le  {REVIEW_DATE}', N' your annual review will be in {REVIEW_DAYS_NUMBER} days time on {REVIEW_DATE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP-Notification', 0, 0, NULL, N'NOTIFICATION_REVIEW', N'ANNUAL_REVIEW')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501209, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a validé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} validated the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_VALIDATE_RECRUITMENT_REQUEST', N'VALIDATE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501213, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a refusé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} refused the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_REFUSE_RECRUITMENT_REQUEST', N'REFUSE_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501214, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a annulé la demande de recrutement {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the recruitment request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_CANCEL_RECRUITMENT_REQUEST', N'CANCEL_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501215, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/recruitment-request/edit', N'{CREATOR} a ajouté un commentaire pour la demande de recrutement{CODE}', N'{CREATOR} added a comment for the recruitment request {CODE}', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 0, 0, NULL, N'NOTIFICATION_ADD_COMMENT_RECRUITMENT_REQUEST', N'ADD_COMMENT_RECRUITMENT_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501226, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employee {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_EXIT_EMPLOYEE_REQUEST', N'VALIDATE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501227, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a refusé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} refused the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_REFUSE_EXIT_EMPLOYEE_REQUEST', N'REFUSE_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501230, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee', N'{CREATOR} a annulé la demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} canceled the exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CANCEL_EXIT_EMPLOYEE_REQUEST', N'CANCEL_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501231, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/exit-employee/show', N'{CREATOR} a ajouté  une demande de sortie employé {DOC_CODE} {PROFIL}', N'{CREATOR} added a new exit employee request {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_EXIT_EMPLOYEE_REQUEST', N'ADD_EXIT_EMPLOYEE_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501232, N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', N'/rh/mobility-request/edit', N'Une demande de mobilité a été ajouté pour {EMPLOYEE_FULLNAME} (depuis son bureau actuel {CURRENT_OFFICE_NAME} vers le bureau {DESTINATION_OFFICE_NAME})', N'A mobility request has been added for{EMPLOYEE_FULLNAME} (from his current office {CURRENT_OFFICE_NAME} to the office {DESTINATION_OFFICE_NAME})', NULL, NULL, NULL, NULL, 0, 0, N'STARK-ERP Notification', 1, 0, NULL, N'NOTIFICATION_ADD_MOBILITY_REQUEST', N'ADD_MOBILITY_REQUEST')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501233, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a partiellement validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has partially validated the timesheet of {MONTH} {PROFILE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_PARTTIALLY_VALIDATED_TIMESHEET', N'PARTTIALLY_VALIDATED_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501234, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a soumis le CRA de {MONTH} {PROFIL}', N'{CREATOR} has submited the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMIT_TIMESHEET', N'SUBMIT_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501235, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a validé le CRA de {MONTH} {PROFIL}', N'{CREATOR} has validated the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_VALIDATE_TIMESHEET', N'VALIDATE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501238, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{CREATOR} a fait une correction du CRA de {MONTH} {PROFIL}', N'{CREATOR} made a correction of the timesheet of {DOC_CODE} {PROFIL}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTE_TIMESHEET', N'CORRECTE_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501239, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'Le CRA du mois de {MONTH} de l''employé {EMPLOYEE} nécessite une correction', N'The timesheet of {MONTH} of {EMPLOYEE} requires a correction', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_CORRECTION_REQUEST_TIMESHEET', N'CORRECTION_REQUEST_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501240, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', N'/rh/timesheet', N'{VALIDATOR} a soumis le CRA {MONTH} de {EMPLOYEE}', N'{VALIDATOR} a submitted the timesheet {MONTH} of {EMPLOYEE}', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_SUBMISSION_TIMESHEET', N'SUBMISSION_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501241, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/rh/timesheet', N'{CREATOR}  a ajouté un commentaire pour votre CRA', N'{CREATOR} has added a note to your timesheet', NULL, NULL, NULL, NULL, 0, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIFICATION_ADD_COMMENT_TIMESHEET', N'ADD_COMMENT_TIMESHEET')
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501244, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/add', N'{CREATOR}{DOC_CODE}{PROFIL}', N'{CREATOR}{DOC_CODE}{PROFIL}', NULL, NULL, NULL, NULL, 1, 1, NULL, 0, 0, NULL, NULL, NULL)
INSERT INTO [ERPSettings].[Information] ([IdInfo], [IdFunctionality], [URL], [FR], [EN], [AR], [DE], [CH], [ES], [IsMail], [IsNotification], [MailSubject], [IsAcceptedInfo], [IsToManager], [IdInfoParent], [TranslationKey], [Type]) VALUES (1000501245, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', N'/payroll/leave/add', N'{CRATOR}{DOC_CODE}{PROFIL}', N'{CRATOR}{DOC_CODE}{PROFIL}', NULL, NULL, NULL, NULL, 1, 1, N'STARK-ERP Notification', 0, 1, NULL, N'NOTIF_ADD_LEAVE', N'ADD_LEAVE')
SET IDENTITY_INSERT [ERPSettings].[Information] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[Privilege] ON
INSERT INTO [ERPSettings].[Privilege] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Reference]) VALUES (1, N'Employé', N'Employé', 0, 0, NULL, N'EMPLOYEE')
INSERT INTO [ERPSettings].[Privilege] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Reference]) VALUES (2, N'Paie', N'Paie', 0, 0, NULL, N'PAY')
INSERT INTO [ERPSettings].[Privilege] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Reference]) VALUES (3, N'Contrat', N'Contrat', 0, 0, NULL, N'CONTRACT')
INSERT INTO [ERPSettings].[Privilege] ([Id], [Label], [Description], [IsDeleted], [TransactionUserId], [Deleted_Token], [Reference]) VALUES (4, N'Poste', N'Poste', 0, 0, NULL, N'JOB')
SET IDENTITY_INSERT [ERPSettings].[Privilege] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] ON
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (1, 87, N'DocumentSparkFr', N' document Fr', N'Document Fr1', N'Spark-Fr', N'SparkFr')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (2, NULL, NULL, N'genericDocumentReport_fr', N'genericDocumentReport_en', N'O-SA', N'genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (3, NULL, NULL, N'genericDocumentReport_fr', N'genericDocumentReport_en', N'O-PU', N'genericDocumentReport')
INSERT INTO [ERPSettings].[ReportTemplate] ([Id], [IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES (4, NULL, NULL, N'genericDocumentReport_fr', N'genericDocumentReport_en', N'D-SA', N'genericDocumentReport')
SET IDENTITY_INSERT [ERPSettings].[ReportTemplate] OFF
GO
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] ON
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1, N'a710d793-9662-486c-8b3b-01d2a592111b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (2, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (3, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (4, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (5, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (6, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (7, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (8, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (9, N'11503286-9245-41ee-a502-caa5ea9cf776', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (10, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (11, N'4191141d-e747-40bd-a448-733d5c23f083', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (12, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (13, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (14, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (15, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (16, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (17, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (18, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (19, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (20, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (21, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (22, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (23, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (24, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (25, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (26, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (27, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (28, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (29, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (30, N'a710d793-9662-486c-8b3b-01d2a592111b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (31, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (32, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (33, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (34, N'11503286-9245-41ee-a502-caa5ea9cf776', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (35, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (36, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (37, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (38, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (39, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (40, N'461500a8-a604-46ab-ab77-8517783aea0d', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (41, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (42, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (43, N'997d1f54-a483-4452-be25-3b9a9eab3884', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (44, N'14110ae1-17a1-446a-a3db-f893a04f4794', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (45, N'b678b40a-e499-4961-862b-eae2ecf7baef', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (46, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (47, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (48, N'ba44579d-71ad-404e-9a65-2e380b698b19', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (49, N'3545d556-108a-4d68-9c99-afc572ba34df', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (50, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (51, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (52, N'a710d793-9662-486c-8b3b-01d2a592111b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (53, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (54, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (55, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (56, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (57, N'4191141d-e747-40bd-a448-733d5c23f083', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (58, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (59, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (60, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (61, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (62, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (63, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (64, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (65, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (66, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (68, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (69, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (70, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (71, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (72, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (73, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (74, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (75, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (76, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (77, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (78, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (79, N'1755151f-da27-40ad-b605-c51624e5779a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (80, N'49c4d264-53af-4038-8466-2ee31b3b915c', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (81, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (82, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (83, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (84, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (85, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (86, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (87, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (88, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (89, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (90, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (91, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (92, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (93, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (94, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (95, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (96, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (97, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (98, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (99, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (100, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (101, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (102, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (103, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (104, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (105, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (106, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (107, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (108, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (109, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (110, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (111, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (112, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (113, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (114, N'de7d394d-0c2d-4819-8434-97acb048467f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (116, N'21188e34-572b-4328-bf25-268df5eb2da0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (118, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (119, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (120, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (121, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (122, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (123, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (126, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (127, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (128, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (129, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (130, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (131, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (132, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (133, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (134, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (135, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (136, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (137, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (138, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (139, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (141, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (142, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (143, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (145, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (146, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (147, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (148, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (149, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (150, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (151, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (152, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (153, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (154, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (155, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (156, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (157, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (158, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (159, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (160, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (161, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (162, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (163, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (164, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (165, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (166, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (168, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (169, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (170, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (171, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (172, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (173, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (174, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (175, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (176, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (177, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (178, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (179, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (180, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (181, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (182, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (183, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (184, N'949f1777-0d49-4e49-b776-34e801b9da85', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (185, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (186, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (187, N'8b43714c-d306-45b4-8d67-311a393e9133', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (188, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (189, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (190, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (191, N'1755151f-da27-40ad-b605-c51624e5779a', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (192, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (193, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (194, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (195, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (196, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (197, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (198, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (199, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (200, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (201, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (202, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (203, N'eeeef661-f871-435a-badd-be1d6c96765b', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (204, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (205, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (206, N'1755151f-da27-40ad-b605-c51624e5779a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (207, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (208, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (209, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (210, N'8b43714c-d306-45b4-8d67-311a393e9133', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (211, N'ae298068-a632-40b3-b2d4-aa4636697160', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (212, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (213, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (214, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (215, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (216, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (217, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (218, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (219, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (220, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (221, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (222, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (223, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (224, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (225, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (226, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (227, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (228, N'927010d6-12da-45af-9a65-a453d766cfcf', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (229, N'49c4d264-53af-4038-8466-2ee31b3b915c', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (230, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (231, N'25200373-be95-4c8b-8f47-ca13ef03341e', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (232, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (233, N'8a648529-4f11-4df5-b569-85958ea994f6', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (234, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (235, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (236, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100001, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (237, N'927010d6-12da-45af-9a65-a453d766cfcf', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (238, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (239, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (240, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (241, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (242, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (243, N'49c4d264-53af-4038-8466-2ee31b3b915c', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (244, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (245, N'8b43714c-d306-45b4-8d67-311a393e9133', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (246, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (247, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (248, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (249, N'8a648529-4f11-4df5-b569-85958ea994f6', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (250, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (251, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (252, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (253, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (254, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (255, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (256, N'ae298068-a632-40b3-b2d4-aa4636697160', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (257, N'deb534e2-0848-48d3-8074-acd7e2805b58', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (258, N'eeeef661-f871-435a-badd-be1d6c96765b', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (259, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (260, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (261, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (262, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (263, N'25200373-be95-4c8b-8f47-ca13ef03341e', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (264, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (265, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (266, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (267, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (268, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (269, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (270, N'1755151f-da27-40ad-b605-c51624e5779a', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (271, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (272, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (273, N'949f1777-0d49-4e49-b776-34e801b9da85', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (298, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (299, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (300, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100005, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (301, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (302, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 100006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (303, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (306, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (307, N'a710d793-9662-486c-8b3b-01d2a592111b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (308, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (309, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (310, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (311, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (312, N'156c4296-861c-4633-ac28-08eac1d8a49e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (313, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (314, N'3567ac24-96e3-4754-8c72-0d17a7b2fa4a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (315, N'38a92b23-2180-4497-ba96-0fe49758074f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (316, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (317, N'51bf3865-133e-4e97-9f81-13564644742d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (318, N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (319, N'5c56d444-523c-4cb3-8554-1a88b3af0779', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (320, N'60b695ae-b5bd-4257-bf76-1ad97af29c07', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (321, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (322, N'e6f0b965-7b14-48f9-8682-1e7cdc019386', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (323, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (324, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (325, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (326, N'21188e34-572b-4328-bf25-268df5eb2da0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (327, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (328, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (329, N'd0ed74ae-f0a9-4be7-89df-28c2d239f69d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (330, N'22367de5-32f0-4fd7-9340-296c7879c03f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (331, N'ba44579d-71ad-404e-9a65-2e380b698b19', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (332, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (333, N'49c4d264-53af-4038-8466-2ee31b3b915c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (334, N'8b43714c-d306-45b4-8d67-311a393e9133', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (335, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (336, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (337, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (338, N'949f1777-0d49-4e49-b776-34e801b9da85', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (339, N'997d1f54-a483-4452-be25-3b9a9eab3884', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (340, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (341, N'101da8f5-e467-4af1-9b19-3d01ca21cf7c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (342, N'f4cf27d5-7292-4b53-bbb4-3e1a10c40e6a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (343, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (344, N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (345, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (346, N'afd3d290-ace7-4571-9444-4334f3171856', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (347, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (348, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (349, N'a9f72604-b294-4035-a890-479a2d17ce10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (350, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (351, N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (352, N'cc4b6a10-a842-4a65-a673-4acea9fb9cac', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (353, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (354, N'52370bb4-ec37-4301-b88a-4eafb5b8bbc1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (355, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (356, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (357, N'8e37e06d-9a6d-453a-a11e-56a41bb9c102', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (358, N'353d9847-1d65-4ba3-8582-57883d8f0267', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (359, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (360, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (361, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (362, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (363, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (364, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (365, N'4191141d-e747-40bd-a448-733d5c23f083', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (366, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (367, N'd2343785-b0e5-4d87-8f03-78d62c876d43', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (368, N'b5f325f6-4bd5-4281-aecd-7ad0312e8d38', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (369, N'ab61832c-08c9-4c1d-8322-7c9e53a9fb74', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (370, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (371, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (372, N'904decde-cef0-4150-9883-83e9839387c2', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (373, N'461500a8-a604-46ab-ab77-8517783aea0d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (374, N'8a648529-4f11-4df5-b569-85958ea994f6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (375, N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (376, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (377, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (378, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (379, N'3e72dcc0-5cf4-4a38-a194-8d24d6085d27', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (380, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (381, N'5b998e60-fe89-4578-83bf-9471bdec317d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (382, N'd1f0441a-a83f-414a-a106-9539a26a58ef', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (383, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (384, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (385, N'de7d394d-0c2d-4819-8434-97acb048467f', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (386, N'21d50a59-9b37-40ec-a5dc-980f8ee08dd5', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (387, N'bea10b66-d2ee-49fe-be89-98b7fb911ff6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (388, N'3cc3c4d2-1e0d-4ed4-978d-99ae2fcfc7eb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (389, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (390, N'd4708d75-55ff-447c-b816-9bf8e174c28d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (391, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (392, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (393, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (394, N'3cd0984a-a8e9-4975-aa51-a23bac267db1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (395, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (396, N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (397, N'927010d6-12da-45af-9a65-a453d766cfcf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (398, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (399, N'ab566211-44ce-44a8-a843-a6764f816249', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (400, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (401, N'ae298068-a632-40b3-b2d4-aa4636697160', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (402, N'deb534e2-0848-48d3-8074-acd7e2805b58', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (403, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (404, N'3545d556-108a-4d68-9c99-afc572ba34df', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (405, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (406, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (407, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (408, N'3bceb952-b852-4d24-9f76-b472b3570486', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (409, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (410, N'214c0463-7e29-4740-acf7-bccec1adfa43', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (411, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (412, N'eeeef661-f871-435a-badd-be1d6c96765b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (413, N'6c3de305-9178-4b15-82f1-be6e1f801cb7', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (414, N'ad5f192c-ffb3-4f6f-a922-bf2e77a00ddc', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (415, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (416, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (417, N'f401508a-a722-4ba3-90d2-c21a2b78713c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (418, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (419, N'1755151f-da27-40ad-b605-c51624e5779a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (420, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (421, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (422, N'25200373-be95-4c8b-8f47-ca13ef03341e', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (423, N'11503286-9245-41ee-a502-caa5ea9cf776', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (424, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (425, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (426, N'a49cd432-de82-40d6-8994-ce2f102039cc', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (427, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (428, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (429, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (430, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (431, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (432, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (433, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (434, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (435, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (436, N'bef67db7-625d-41e7-99ae-e116177d04a1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (437, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (438, N'4ab9f044-39b3-4ba2-8830-e86ab9971d49', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (439, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (440, N'081ef980-e302-4386-89fa-ea31857b1c2d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (441, N'b678b40a-e499-4961-862b-eae2ecf7baef', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (442, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (443, N'659f9dfd-ad67-4129-8d2d-ebc28cc54334', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (444, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (445, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (446, N'3f092f7b-64cf-4ec9-b571-ee69defc3310', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (447, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (448, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (449, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (450, N'a1c1288e-6557-4a5d-b12d-f32e8d48629a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (451, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (452, N'5a5c5ec9-09c7-4151-a811-f6ee9585a73a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (453, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (454, N'14110ae1-17a1-446a-a3db-f893a04f4794', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (455, N'6f8c74fc-16ef-4c45-8a69-fe8a7e4c6304', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (456, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (457, N'a49cd432-de82-40d6-8994-ce2f102039cc', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (458, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (459, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (460, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (461, N'c6e3c3d5-00b7-43d6-a846-d37f274d1de3', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (462, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (463, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (464, N'd2a84b17-2b65-47a4-b99c-d73ca806e0fb', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (465, N'5dcb7310-a80e-40fa-8e09-dc64537a2e10', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (466, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (467, N'bef67db7-625d-41e7-99ae-e116177d04a1', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (468, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (469, N'4ab9f044-39b3-4ba2-8830-e86ab9971d49', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (470, N'eb59fddc-6dd7-4629-b4d1-ea1745794a73', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (471, N'081ef980-e302-4386-89fa-ea31857b1c2d', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (472, N'b678b40a-e499-4961-862b-eae2ecf7baef', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (473, N'7e5ac492-0987-4d51-b14e-eb0e7c58de75', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (474, N'659f9dfd-ad67-4129-8d2d-ebc28cc54334', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (475, N'5a19bde6-fa86-4511-97ae-ec4c2fb61786', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (476, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (477, N'3f092f7b-64cf-4ec9-b571-ee69defc3310', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (478, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (479, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (480, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (481, N'a1c1288e-6557-4a5d-b12d-f32e8d48629a', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (482, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (483, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (484, N'79ce368b-ad81-4973-aae7-ff402f34cfbf', 90000, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (485, N'79ce368b-ad81-4973-aae7-ff402f34cfbf', 101016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (486, N'11690986-d81d-43b6-b47d-d930abe49776', 101016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (487, N'fd671f2f-5b90-4de3-9a07-157b4a3c8477', 70002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (488, N'fd671f2f-5b90-4de3-9a07-167b4a3c8477', 70003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (489, N'fd671f2f-5b90-4de3-9a07-777b4a3c8477', 70013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (490, N'fd671f2f-5b90-4de3-9a07-187b4a3c8477', 70005, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (491, N'fd671f2f-5b90-4de3-9a07-197b4a3c8477', 70006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (492, N'fd671f2f-5b90-4de3-9a07-707b4a3c8477', 70012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (493, N'fd671f2f-5b90-4de3-9a07-217b4a3c8477', 70008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (494, N'fd671f2f-5b90-4de3-9a07-227b4a3c8477', 70009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (495, N'fd671f2f-5b90-4de3-9a07-237b4a3c8477', 70010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (496, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (497, N'4191141d-e747-40bd-a448-733d5c23f083', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (498, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (499, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (500, N'4609408f-7f48-4a57-8bfb-f1f0b108099b', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (501, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (502, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (503, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (504, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (505, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (506, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (507, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (508, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (509, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (510, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (511, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (512, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (513, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (514, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (515, N'a710d793-9662-486c-8b3b-01d2a592111b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (516, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (517, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (518, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (519, N'11503286-9245-41ee-a502-caa5ea9cf776', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (520, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (521, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (522, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (523, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (524, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (525, N'461500a8-a604-46ab-ab77-8517783aea0d', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (526, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (527, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (528, N'997d1f54-a483-4452-be25-3b9a9eab3884', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (529, N'14110ae1-17a1-446a-a3db-f893a04f4794', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (530, N'b678b40a-e499-4961-862b-eae2ecf7baef', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (531, N'13446b5b-e1be-49d0-a0d4-332f7ab7febe', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (532, N'41b49c2f-ab23-4c77-af9c-2830a759fe6a', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (533, N'ba44579d-71ad-404e-9a65-2e380b698b19', 22222, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (534, N'3545d556-108a-4d68-9c99-afc572ba34df', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (535, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (536, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (537, N'a710d793-9662-486c-8b3b-01d2a592111b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (538, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (539, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (540, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (541, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (542, N'4191141d-e747-40bd-a448-733d5c23f083', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (543, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (544, N'915b6d28-0e22-4b21-ba0a-ed1cdc981f20', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (545, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (546, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (547, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (548, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (549, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (550, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (551, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (552, N'd407d85f-428f-42d2-9a7c-e7812f23fbc9', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (553, N'9ca06367-ad8b-4aa1-8994-316241dcd5de', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (554, N'138fac1b-7921-4844-ae68-637a2aabb2c3', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (555, N'2bc26ad8-1542-4b1f-8fb0-659133434fc1', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (556, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (557, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (558, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (559, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (560, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (561, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (562, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (563, N'1755151f-da27-40ad-b605-c51624e5779a', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (564, N'49c4d264-53af-4038-8466-2ee31b3b915c', 33333, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (565, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (566, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (567, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (568, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (569, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (570, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 44444, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (571, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (572, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (573, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (574, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (575, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (576, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (577, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (578, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (579, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (580, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (581, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (582, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (583, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (584, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (585, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (586, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (587, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (588, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (589, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (590, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (591, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (592, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (593, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (594, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (595, N'2a5e908b-e151-4ea8-939a-8271b74b8a13', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (596, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (597, N'de7d394d-0c2d-4819-8434-97acb048467f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (599, N'21188e34-572b-4328-bf25-268df5eb2da0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (601, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (602, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (603, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (604, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (605, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (606, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (609, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (610, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (611, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (612, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (613, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (614, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (615, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (616, N'8cab7af9-78ef-4a95-88a6-ce059225323c', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (617, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (618, N'e7e94ca1-eace-4b30-88d6-48286320eae1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (619, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (620, N'ae298068-a632-40b3-b2d4-aa4636697160', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (621, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (622, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (624, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (625, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (626, N'38a92b23-2180-4497-ba96-0fe49758074f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (628, N'4191141d-e747-40bd-a448-733d5c23f083', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (629, N'adc0c601-b5bc-4fb7-8e62-f1f87d44e988', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (630, N'904decde-cef0-4150-9883-83e9839387c2', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (631, N'289338c0-09ad-46e1-a893-c1aa2ed79cf4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (632, N'afd3d290-ace7-4571-9444-4334f3171856', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (633, N'e5947a1e-9db3-486a-b26c-b33be5e0a82e', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (634, N'fbb149f9-4d23-43d7-8576-0078daa06f8d', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (635, N'a9f72604-b294-4035-a890-479a2d17ce10', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (636, N'd02ccb30-71cf-4a57-8327-333be69e8af4', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (637, N'3bceb952-b852-4d24-9f76-b472b3570486', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (638, N'11503286-9245-41ee-a502-caa5ea9cf776', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (639, N'22b1f11f-8129-4128-ae3e-870d327bb4ae', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (640, N'22367de5-32f0-4fd7-9340-296c7879c03f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (641, N'0d8556e4-3f5e-44ed-aea6-c00c28593219', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (642, N'12e372a0-52f7-4089-a3f4-a96cf646b6fb', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (643, N'3a3ed20b-f313-4b1b-9879-a287af094ff0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (644, N'9a66818c-8385-49fa-a6ae-08ade53622e1', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (645, N'a209794d-4f0f-4fff-b715-a03556e3ed87', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (646, N'a710d793-9662-486c-8b3b-01d2a592111b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (647, N'1bdc6aaa-db4b-4862-9758-4382fd0e656a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (648, N'9f2cfcec-57ba-4b40-9f16-6cb3e1b7b960', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (649, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (651, N'0b5ab8e8-2434-4631-b03c-58bc146ac66b', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (652, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (653, N'efa1d60e-933b-4749-bac3-a15e8bba3415', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (654, N'5eef2177-47d5-4780-b338-46e284f8ce4a', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (655, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (656, N'08565d6a-47e9-4554-a9d5-9abfd44e48f0', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (657, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (658, N'3545d556-108a-4d68-9c99-afc572ba34df', 77777, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (659, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (660, N'd19420b6-2887-4f56-acc4-f003c33f1d89', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (661, N'b37d468b-f8f5-4eee-827a-e0b2fc6881ed', 88888, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (662, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (663, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (668, N'358a8785-5176-4324-910a-7d61e2a32620', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (669, N'e86a8c4c-4118-4c9b-9026-29105889eacd', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (670, N'2d5ff4ca-3e7a-45a3-b036-6724c12441cf', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (671, N'b2232bc4-7845-4e4a-8442-e4c57bd4b327', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (672, N'2a1204d0-84eb-4c01-80ba-2cdebc606af8', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (673, N'10b2b574-72a5-4451-973a-7b3a5d1d40a0', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (674, N'cec1e328-22a8-4f2b-81e3-e05a8e4d4541', 100008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (675, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100005, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (676, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 11111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (677, N'9ccf8314-260b-4550-80c8-ff4969eede46', 100006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (678, N'3b276df5-4e7f-4659-905f-55192a9489c3', 100006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (679, N'1ad10d89-f0bc-415d-9979-a535cf29429f', 100006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (680, N'79a04bc4-6c3d-4d7d-9566-cb6e25c389c0', 101036, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (681, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (682, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (683, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (684, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (685, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (686, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (687, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (688, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (689, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100012, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (690, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (691, N'610782eb-cc27-4bde-b2be-b86878fecbdd', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (692, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (693, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (694, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (695, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (696, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (697, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100014, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (698, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (699, N'27d0eb9e-0653-459f-a06f-d2e3c6ad8a9b', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (700, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (701, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100015, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (702, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (703, N'9b03405e-cb73-4c79-949e-9cd216ece4c4', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (704, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (705, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100016, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (706, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (707, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (708, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (709, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (710, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (711, N'87b84a91-98fd-49f1-80f3-04630d73ed79', 100018, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (714, N'ae4ae5f7-280b-4a93-9330-96033bfa303a', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (715, N'159000fc-7090-48c5-bcc2-8e8cb688e8a9', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (716, N'fa2ef934-cf6b-44e6-a15d-08f924a6d903', 100022, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (717, N'9ccf8314-260b-4550-80c8-ff4969eede46', 100021, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (718, N'1ad10d89-f0bc-415d-9979-a535cf29429f', 100021, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (719, N'9ccf8314-260b-4550-80c8-ff4969eede46', 100020, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (720, N'3b276df5-4e7f-4659-905f-55192a9489c3', 100020, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (721, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100023, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (722, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 100023, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (723, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (724, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (725, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (726, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (727, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100027, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (728, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (729, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (730, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (731, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (732, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100026, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (733, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (734, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (735, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (736, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (737, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (738, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (739, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (740, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (741, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (742, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100024, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (743, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (744, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (745, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (746, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (747, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (748, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (749, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (750, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (751, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (752, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (753, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (754, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (755, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (756, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (757, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (758, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100031, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (759, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (760, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (761, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (762, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 100032, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (763, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (764, N'e30959c4-61bb-457e-b44e-271c04a9e49d', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (765, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (766, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100033, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (767, N'05462ee4-4426-45de-9386-6a61473b725d', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (768, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (769, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (770, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (771, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (772, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100034, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (773, N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (774, N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (775, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (776, N'd1f0441a-a83f-414a-a106-9539a26a58ef', 100025, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (777, N'8a2e43c4-0113-4ba0-92ab-3fbd79867c3a', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (778, N'93ef9743-1ce5-4ba0-9dff-4aa13af4b01f', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (779, N'964167cb-03f3-4cdb-9b52-87564f6dda2f', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (780, N'd1f0441a-a83f-414a-a106-9539a26a58ef', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (781, N'3fbbf8c3-1ed2-445e-b6e9-752c10eb49c9', 100036, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (782, N'e55c8fd9-ac89-4986-9291-afe0d5c02490', 100037, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (783, N'361806f0-f88e-4b5e-bda6-68c34fb1faea', 100038, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (784, N'e0367d41-2d4b-4f85-9e7a-244803c29221', 100039, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (785, N'1ad10d89-f0bc-415d-9979-a535cf29429f', 100041, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (786, N'3b276df5-4e7f-4659-905f-55192a9489c3', 100042, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (787, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 100043, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (788, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 100044, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (789, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 100045, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (790, N'55dd99c2-f37c-4a1b-b8cf-1e44423f3018', 100046, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (791, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 100047, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (792, N'22327ce7-b81c-4c0f-ac75-b1c4ced325c1', 100048, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (793, N'1b8c288b-6fb4-4816-964b-ce7b89339db9', 100049, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (794, N'fdc3ed27-ac8a-4256-a340-ce96961358d6', 100051, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (795, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 100052, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (796, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 100053, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (797, N'a0092569-9901-4fea-96e1-4cd96ea0eaed', 100054, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (798, N'0934b53e-48dd-4693-bca2-f6a5ce39b359', 100055, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (799, N'05462ee4-4426-45de-9386-6a61473b725d', 100056, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (800, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 100057, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (801, N'0271afdd-63e8-4b4c-884f-960dcb719c7c', 100058, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (802, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100059, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (803, N'5c413b36-8269-447a-a462-210e9f0fd93b', 100060, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (804, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100060, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (805, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101038, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (806, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 101038, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (807, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101039, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (808, N'783fe0a6-0d38-43a3-8b41-42039da2ed3f', 101039, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (809, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 100062, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (810, N'937d9bd7-2975-4d4f-a063-ed11d7288dd5', 101040, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (811, N'fd671f2f-5b90-4de3-9a07-157b4a3c8477', 70002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (812, N'fd671f2f-5b90-4de3-9a07-167b4a3c8477', 70003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (813, N'fd671f2f-5b90-4de3-9a07-177b4a3c8477', 70004, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (814, N'fd671f2f-5b90-4de3-9a07-187b4a3c8477', 70005, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (815, N'fd671f2f-5b90-4de3-9a07-197b4a3c8477', 70006, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (816, N'fd671f2f-5b90-4de3-9a07-207b4a3c8477', 70007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (817, N'a7168571-d1dd-4de1-8bb4-bd9d1816bab0', 101041, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (818, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 101042, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (819, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 101043, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (820, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101044, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (821, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100166, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1010, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101045, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1011, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 101045, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1016, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1017, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 101013, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1020, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1021, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 101011, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1022, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1023, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1024, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1025, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101009, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1026, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1027, N'214c0463-7e29-4740-acf7-bccec1adfa43', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1028, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1029, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1030, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1031, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 101008, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1032, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1033, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1034, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1035, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1036, N'7df17a2a-bfbd-4753-a61d-7f010d64cad7', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1037, N'f40650cb-aa58-48a8-a4df-9744e6b81698', 100010, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1038, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1039, N'ba3b0e01-71c9-4513-9d3e-2e94d681b195', 100007, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1040, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1041, N'bf043378-ebc1-4c83-ba68-f78da6ef36ec', 101017, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1042, N'bb44b92d-de84-4bc7-bd5e-3f0b2f29e16a', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1043, N'd8661332-0a12-4d10-98fe-4f7e5b91c6a8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1044, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1045, N'2f7d95d8-883a-445e-9ec2-3c4a70854f68', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1046, N'214c0463-7e29-4740-acf7-bccec1adfa43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1047, N'94a36607-432f-483b-aecf-8c0d3d19f47b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1048, N'155b0f5c-f9a0-4f3d-aae5-85a75a7ffacd', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1049, N'd2343785-b0e5-4d87-8f03-78d62c876d43', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1050, N'ce31e87c-a47e-4c35-a81f-16f6aa695c11', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1051, N'5c56d444-523c-4cb3-8554-1a88b3af0779', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1052, N'a49cd432-de82-40d6-8994-ce2f102039cc', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1053, N'd23aaf9e-127b-417c-ba8a-a31c41c3a97e', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1054, N'21188e34-572b-4328-bf25-268df5eb2da0', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1055, N'51bf3865-133e-4e97-9f81-13564644742d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1056, N'79ce368b-ad81-4973-aae3-ff402f34cfbf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1057, N'15404a12-4c4e-485a-a2c8-bda14d9a35d8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1058, N'45f73dc7-e9e7-41c1-9a09-af1b40527dcf', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1059, N'f8ff6b5e-d60b-4b83-9934-d6eee590c523', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1060, N'3f5ce072-55c8-485e-9a09-1f2f69c043e8', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1061, N'dca0e118-de89-4b9d-a25b-08964a3856b9', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1062, N'924d8e7e-1e50-4926-8dcb-c69d7de14a3b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1063, N'05e66fa8-2cfe-4663-a30d-13454e8fbd5b', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1064, N'5b998e60-fe89-4578-83bf-9471bdec317d', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1065, N'8655e017-b3e2-49bd-8a4a-c84d3abed569', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1066, N'ac1db73f-5b3c-475b-b404-3495d78c499a', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1256, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101019, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1257, N'6b8130e1-c753-468d-90a7-cb95b2ca4eec', 101019, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1461, N'6b8130e1-c753-468d-90a7-cb95b2ca4eec', 100003, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1462, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1463, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1464, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1465, N'ff007474-a447-4c92-8f6a-265d5c08ff10', 101081, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1466, N'51bf3865-133e-4e97-9f81-14564644742d', 101091, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1467, N'51bf3865-133e-4e97-9f99-14564644742d', 10155, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1468, N'bc471d71-863e-47a0-95f4-c2e1595c2bd9', 100029, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1469, N'8786ac1b-297a-410c-8f2a-4fa850ecdbba', 100030, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1470, N'0aa2abaa-8057-4bd3-8a64-d6c16552aaf6', 100028, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1672, N'46544cb0-f35f-45cd-ba1f-bcf6fc94a29f', 100002, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1673, N'51bf3865-133e-4e97-9f99-14564655242d', 101094, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1674, N'51bf3865-133e-4e97-9f99-14564643777d', 102104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1675, N'51bf3865-133e-4e97-9f99-14564643332d', 101092, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1676, N'51bf3865-133e-4e97-9f99-14564649992d', 101100, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1677, N'24548e5d-76cc-4fc8-a7ee-02986b9274a7', 101104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1678, N'589d24dd-72de-4588-9891-a620c2409e29', 101104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1679, N'51bf3865-133e-4e97-9f99-14564645642d', 101101, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1680, N'51bf3865-133e-4e97-9f99-14564688632d', 101103, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1681, N'51bf3865-133e-4e97-9f99-14564687942d', 101102, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1682, N'51bf3865-133e-4e97-9f99-11564687942d', 102101, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1683, N'51bf3865-133e-4e97-9f99-33564687942d', 102102, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1684, N'51bf3865-133e-4e97-9f99-10562227942d', 102103, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1685, N'51bf3865-133e-4e97-9f99-10562227120d', 103104, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1686, N'51bf3865-133e-4e97-9f99-10562227121d', 103105, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1687, N'51bf3865-133e-4e97-9f99-10562227122d', 103106, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1688, N'51bf3865-133e-4e97-9f99-10562227123d', 103107, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1689, N'51bf3865-133e-4e97-9f99-10562227124d', 103108, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1690, N'51bf3865-133e-4e97-9f99-10562227125d', 103109, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1691, N'51bf3865-133e-4e97-9f99-10562227126d', 103110, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1692, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 103111, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1693, N'51bf3865-133e-4e97-9f99-10562227201d', 103112, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1694, N'51bf3865-133e-4e97-9f99-10562227202d', 103113, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1695, N'817d920f-48ef-4aa2-865a-cc367c37fb3b', 103114, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1696, N'd438fbad-7305-4dad-ab44-a4fb84318a83', 103115, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1697, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103116, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1698, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103117, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1699, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103118, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1700, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103119, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1701, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103123, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1702, N'87beb2e4-efeb-4341-b96b-6e6bec8a308a', 103124, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1703, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 103120, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1704, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 103121, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1705, N'2193ddf9-9631-4aaf-bb15-5f95fc25e44f', 103122, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1706, N'a339ba07-b6f7-4da3-ba28-447a15271b08', 103125, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1707, N'103bca79-07c4-471b-9381-5d4f7f64e27f', 103126, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1708, N'026acaf2-9828-4fb9-9abe-0ac5588e5446', 103127, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1709, N'bc4b504c-9397-4f65-92bd-fc556e30943f', 103128, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1710, N'3c84c73b-80f7-4441-b7dc-c3a6768b49e5', 103129, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1711, N'51bf3865-133e-4e97-9f99-10562227601d', 103130, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1712, N'51bf3865-133e-4e97-9f99-10562227602d', 103131, 1)
INSERT INTO [ERPSettings].[ModuleConfig] ([Id], [IdModule], [IdRoleConfig], [IsActive]) VALUES (1713, N'a6acf5d2-8e3d-402c-9f61-72e52721cf6b', 103132, 1)
SET IDENTITY_INSERT [ERPSettings].[ModuleConfig] OFF
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ModuleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_ModuleConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[Module]
    ADD CONSTRAINT [FK_Module_Module] FOREIGN KEY ([IdModuleParent]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[ReportTemplate]
    ADD CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Information] FOREIGN KEY ([IdInfoParent]) REFERENCES [ERPSettings].[Information] ([IdInfo])
ALTER TABLE [ERPSettings].[Information]
    ADD CONSTRAINT [FK_Information_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[RoleConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_RoleConfigCategory_RoleConfig] FOREIGN KEY ([IdRoleConfigCategory]) REFERENCES [ERPSettings].[RoleConfigCategory] ([Id])
COMMIT TRANSACTION
