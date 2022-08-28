/*
Ce script a été créé par Visual Studio dans 16/10/2020 à 14:30.
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
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Functionality]
ALTER TABLE [ERPSettings].[FunctionnalityModule] DROP CONSTRAINT [FK_FunctionnalityModule_Module]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_RoleConfig]
ALTER TABLE [ERPSettings].[FunctionalityConfig] DROP CONSTRAINT [FK_FonctionalityConfig_Functionality]
ALTER TABLE [ERPSettings].[Functionality] DROP CONSTRAINT [FK_Functionality_RequestType]
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'fd671f2f-5b91-4de3-9a07-125b4a3c8499'
DELETE FROM [ERPSettings].[FunctionnalityModule] WHERE [IdFunctionnalityModule]=N'fd671f2f-5b91-4de3-9a07-126b4a3c8499'
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16358
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16359
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16360
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16361
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16362
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16363
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16364
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16365
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16366
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16367
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16368
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16369
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16370
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16371
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16372
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16373
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16374
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16375
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16376
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16377
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16378
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16379
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16380
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16381
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16382
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16383
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16384
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16385
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16386
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16387
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16388
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16389
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16390
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16391
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16392
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16393
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16394
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16395
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16396
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16397
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16398
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16399
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16400
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16401
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16402
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16403
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16404
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16405
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16406
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16407
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16408
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16409
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16410
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16411
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16412
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16413
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16414
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16415
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16416
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16417
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16418
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16419
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16420
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16421
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16422
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16423
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16424
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16425
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16426
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16427
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16428
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16429
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16430
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16431
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16432
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16433
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16434
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16435
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16436
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16437
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16438
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16439
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16440
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16441
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16442
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16443
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16444
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16445
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16446
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16447
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16448
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16449
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16450
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16451
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16452
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16453
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16454
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16455
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16456
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16457
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16458
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16459
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16460
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16461
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16462
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16463
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16464
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16465
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16466
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16467
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16468
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16469
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16470
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16471
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16472
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16473
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16474
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16475
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16476
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16477
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16478
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16479
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16480
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16481
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16482
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16483
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16484
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16485
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16486
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16487
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16488
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16489
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16490
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16491
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16492
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16493
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16494
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16495
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16496
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16497
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16498
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16499
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16500
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16501
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16502
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16503
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16504
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16505
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16506
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16507
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16508
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16509
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16510
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16511
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16512
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16513
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16514
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16515
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16516
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16517
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16518
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16519
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16520
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16521
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16522
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16523
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16524
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16525
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16526
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16527
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16528
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16529
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16530
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16531
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16532
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16533
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16534
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16535
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16536
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16537
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16538
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16539
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16540
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16541
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16542
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16543
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16544
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16545
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16546
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16547
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16548
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16549
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16550
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16551
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16552
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16553
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16554
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16555
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16556
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16557
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16558
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16559
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16560
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16561
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16562
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16563
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16564
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16565
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16566
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16567
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16568
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16569
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16570
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16571
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16572
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16573
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16574
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16575
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16576
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16577
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16578
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16579
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16580
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16581
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16582
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16583
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16584
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16585
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16586
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16587
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16588
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16589
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16590
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16591
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16592
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16593
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16594
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16595
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16596
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16597
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16598
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16599
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16600
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16601
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16602
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16603
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16604
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16605
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16606
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16607
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16608
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16609
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16610
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16611
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16612
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16613
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16614
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16615
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16616
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16617
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16618
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16619
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16620
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16621
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16622
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16623
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16624
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16625
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16626
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16627
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16628
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16629
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16630
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16631
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16632
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16633
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16634
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16635
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16636
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16637
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16638
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16639
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16640
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16641
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16642
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16643
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16644
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16645
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16646
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16647
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16648
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16649
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16650
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16651
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16652
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16653
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16654
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16655
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16656
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16657
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16658
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16659
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16660
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16661
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16662
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16663
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16664
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16665
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16666
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16667
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16668
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16669
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16670
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16671
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16672
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16673
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16674
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16675
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16676
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16677
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16678
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16679
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16680
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16681
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16682
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16683
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16684
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16685
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16686
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16687
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16688
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16689
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16690
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16691
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16692
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16693
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16694
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16695
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16696
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16697
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16698
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16699
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16700
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16701
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16702
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16703
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16704
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16705
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16706
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16707
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16708
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16709
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16710
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16711
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16712
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16713
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16714
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16715
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16716
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16717
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16718
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16719
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16720
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16721
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16722
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16723
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16724
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16725
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16726
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16727
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16728
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16729
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16730
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16731
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16732
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16733
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16734
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16735
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16736
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16737
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16738
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16739
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16740
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16741
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16742
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16743
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16744
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16745
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16746
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16747
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16748
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16749
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16750
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16751
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16752
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16753
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16754
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16755
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16756
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16757
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16758
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16759
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16760
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16761
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16762
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16763
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16764
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16765
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16766
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16767
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16768
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16769
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16770
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16771
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16772
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16773
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16774
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16775
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16776
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16777
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16778
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16779
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16780
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16781
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16782
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16783
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16784
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16785
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16786
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16787
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16788
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16789
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16790
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16791
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16792
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16793
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16794
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16795
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16796
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16797
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16798
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16799
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16800
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16801
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16802
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16803
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16804
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16805
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16806
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16807
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16808
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16809
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16810
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16811
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16812
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16813
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16814
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16815
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16816
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16817
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16818
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16819
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16820
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16821
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16822
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16823
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16824
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16825
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16826
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16827
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16828
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16829
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16830
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16831
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16832
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16833
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16834
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16835
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16836
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16837
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16838
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16839
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16840
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16841
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16842
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16843
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16844
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16845
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16846
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16847
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16848
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16849
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16850
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16851
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16852
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16853
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16854
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16855
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16856
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16857
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16858
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16859
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16860
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16861
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16862
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16863
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16864
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16865
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16866
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16867
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16868
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16869
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16870
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16871
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16872
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16873
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16874
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16875
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16876
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16877
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16878
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16879
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16880
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16881
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16882
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16883
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16884
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16885
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16886
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16887
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16888
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16889
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16890
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16891
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16892
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16893
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16894
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16895
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16896
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16897
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16898
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16899
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16900
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16901
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16902
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16903
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16904
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16905
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16906
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16907
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16908
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16909
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16910
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16911
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16912
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16913
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16914
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16915
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16916
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16917
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16918
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16919
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16920
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16921
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16922
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16923
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16924
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16925
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16926
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16927
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16928
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16929
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16930
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16931
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16932
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16933
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16934
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16935
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16936
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16937
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16938
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16939
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16940
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16941
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16942
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16943
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16944
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16945
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16946
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16947
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16948
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16949
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16950
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16951
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16952
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16953
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16954
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16955
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16956
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16957
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16958
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16959
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16960
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16961
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16962
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16963
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16964
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16965
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16966
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16967
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16968
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16969
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16970
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16971
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16972
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16973
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16974
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16975
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16976
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16977
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16978
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16979
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16980
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16985
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16986
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16987
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16988
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16989
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16990
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16991
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16992
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16993
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16994
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16995
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16996
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16997
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16998
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=16999
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17000
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17001
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17002
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17003
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17004
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17005
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17006
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17007
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17008
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17009
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17010
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17011
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17012
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17013
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17014
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17015
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17016
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17017
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17018
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17019
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17020
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17021
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17022
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17023
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17024
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17025
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17026
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17027
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17028
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17029
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17030
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17031
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17032
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17033
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17034
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17035
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17036
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17037
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17038
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17039
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17040
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17041
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17042
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17043
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17044
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17045
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17046
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17047
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17048
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17049
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17050
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17051
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17052
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17053
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17054
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17055
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17056
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17057
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17058
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17059
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17060
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17061
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17062
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17063
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17064
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17065
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17066
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17067
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17068
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17069
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17070
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17071
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17072
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17073
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17074
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17075
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17076
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17077
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17078
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17079
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17080
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17081
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17082
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17083
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17084
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17085
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17086
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17087
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17088
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17089
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17090
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17091
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17092
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17093
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17094
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17095
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17096
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17097
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17098
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17099
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17100
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17101
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17102
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17103
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17104
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17105
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17106
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17107
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17108
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17109
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17110
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17111
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17112
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17113
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17114
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17115
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17116
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17117
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17118
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17119
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17120
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17121
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17122
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17123
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17124
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17125
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17126
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17128
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17129
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17130
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17131
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17132
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17133
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17134
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17135
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17136
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17137
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17138
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17139
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17140
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17141
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17142
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17143
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17144
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17145
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17146
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17147
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17148
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17149
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17150
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17151
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17152
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17153
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17154
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17155
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17156
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17157
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17158
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17159
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17160
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17161
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17162
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17163
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17164
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17165
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17166
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17167
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17168
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17169
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17170
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17171
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17172
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17173
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17174
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17175
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17176
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17177
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17178
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17179
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17180
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17181
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17182
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17183
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17184
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17185
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17186
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17187
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17188
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17189
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17190
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17191
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17192
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17193
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17194
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17195
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17196
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17197
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17198
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17199
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17200
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17201
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17202
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17203
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17204
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17205
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17207
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17208
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17209
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17210
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17211
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17212
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17213
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17214
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17215
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17216
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17217
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17218
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17219
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17220
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17221
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17222
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17223
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17224
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17225
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17226
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17227
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17228
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17229
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17230
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17231
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17232
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17233
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17234
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17235
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17236
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17237
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17238
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17239
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17240
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17241
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17242
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17243
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17244
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17245
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17246
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17247
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17248
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17249
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17250
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17251
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17252
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17253
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17254
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17255
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17256
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17257
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17258
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17259
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17260
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17261
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17262
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17263
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17264
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17265
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17266
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17267
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17268
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17269
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17270
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17271
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17272
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17273
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17274
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17275
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17276
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17277
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17278
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17279
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17280
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17281
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17282
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17283
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17284
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17285
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17286
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17287
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17288
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17289
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17290
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17291
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17292
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17293
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17294
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17295
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17296
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17297
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17298
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17299
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17300
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17301
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17302
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17303
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17304
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17305
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17306
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17307
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17308
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17309
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17310
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17311
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17312
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17313
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17314
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17315
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17316
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17317
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17318
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17319
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17320
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17321
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17322
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17323
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17324
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17325
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17326
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17327
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17328
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17329
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17330
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17331
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17332
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17333
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17334
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17335
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17336
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17337
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17338
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17339
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17340
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17341
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17342
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17343
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17344
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17345
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17346
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17347
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17348
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17349
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17350
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17351
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17352
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17353
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17354
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17355
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17356
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17357
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17358
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17359
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17360
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17361
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17362
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17363
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17364
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17365
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17366
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17367
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17368
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17369
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17370
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17371
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17372
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17373
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17374
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17375
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17376
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17377
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17378
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17379
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17380
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17381
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17382
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17383
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17384
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17385
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17386
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17387
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17388
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17389
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17390
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17391
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17392
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17393
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17394
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17395
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17396
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17397
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17398
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17399
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17400
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17401
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17402
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17403
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17404
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17405
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17406
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17407
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17408
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17409
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17410
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17411
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17412
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17413
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17414
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17415
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17416
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17417
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17418
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17419
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17420
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17421
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17422
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17423
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17424
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17425
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17426
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17427
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17428
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17429
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17430
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17431
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17432
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17433
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17434
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17435
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17436
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17437
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17438
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17439
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17440
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17441
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17442
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17443
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17444
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17445
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17446
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17447
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17448
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17449
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17450
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17451
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17452
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17453
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17454
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17455
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17456
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17457
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17458
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17459
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17460
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17461
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17462
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17463
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17464
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17465
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17466
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17467
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17468
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17469
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17470
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17471
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17472
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17473
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17474
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17475
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17476
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17477
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17478
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17479
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17480
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17481
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17482
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17483
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17484
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17485
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17486
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17487
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17488
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17489
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17490
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17491
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17492
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17493
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17494
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17495
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17496
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17497
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17498
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17499
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17500
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17501
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17502
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17503
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17504
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17505
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17506
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17507
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17508
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17509
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17510
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17511
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17512
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17513
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17514
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17515
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17516
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17517
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17518
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17519
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17520
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17521
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17522
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17523
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17524
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17525
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17526
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17527
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17528
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17529
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17530
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17531
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17532
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17533
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17534
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17535
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17536
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17537
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17538
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17539
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17540
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17541
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17542
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17543
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17544
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17545
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17546
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17547
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17548
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17549
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17550
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17551
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17552
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17553
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17554
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17555
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17556
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17557
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17558
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17559
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17560
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17561
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17562
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17563
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17564
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17565
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17566
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17567
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17568
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17569
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17570
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17571
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17572
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17573
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17574
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17575
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17576
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17577
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17578
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17579
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17580
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17581
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17582
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17583
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17584
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17585
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17586
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17587
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17588
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17589
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17590
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17591
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17592
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17593
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17594
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17595
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17596
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17597
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17598
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17599
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17600
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17601
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17602
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17603
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17604
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17605
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17606
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17607
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17608
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17609
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17610
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17611
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17612
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17613
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17614
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17615
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17616
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17617
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17618
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17619
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17620
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17621
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17622
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17623
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17624
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17625
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17626
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17627
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17628
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17629
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17630
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17631
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17632
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17633
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17634
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17635
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17636
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17637
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17638
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17639
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17640
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17641
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17642
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17643
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17644
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17645
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17646
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17647
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17648
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17649
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17650
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17651
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17652
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17653
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17654
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17655
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17656
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17657
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17658
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17659
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17660
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17661
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17662
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17663
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17664
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17665
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17666
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17667
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17668
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17669
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17670
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17671
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17672
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17673
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17674
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17675
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17676
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17677
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17678
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17679
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17680
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17681
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17682
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17683
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17684
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17685
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17686
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17687
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17688
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17689
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17690
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17691
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17692
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17693
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17694
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17695
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17696
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17697
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17698
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17699
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17700
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17701
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17702
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17703
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17704
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17705
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17706
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17707
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17708
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17709
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17710
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17711
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17712
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17713
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17714
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17715
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17716
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17717
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17718
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17719
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17720
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17721
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17722
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17723
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17724
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17725
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17726
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17727
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17728
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17729
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17730
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17731
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17732
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17733
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17734
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17735
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17736
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17737
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17738
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17739
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17740
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17741
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17742
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17743
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17744
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17745
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17746
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17747
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17748
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17749
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17750
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17751
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17752
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17753
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17754
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17755
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17756
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17757
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17758
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17759
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17760
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17761
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17762
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17763
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17764
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17765
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17766
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17767
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17768
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17769
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17770
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17771
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17772
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17773
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17774
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17775
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17776
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17777
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17778
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17779
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17780
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17781
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17782
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17783
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17784
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17785
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17786
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17787
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17788
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17789
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17790
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17791
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17792
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17793
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17794
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17795
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17796
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17797
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17798
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17799
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17800
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17801
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17802
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17803
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17804
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17805
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17806
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17807
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17808
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17809
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17810
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17811
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17812
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17813
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17814
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17815
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17816
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17817
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17818
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17819
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17820
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17821
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17822
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17823
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17824
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17825
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17826
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17827
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17828
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17829
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17830
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17831
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17832
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17833
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17834
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17835
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17836
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17837
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17838
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17839
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17840
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17841
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17842
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17843
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17844
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17845
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17846
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17847
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17848
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17849
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17850
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17851
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17852
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17853
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17854
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17855
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17856
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17857
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17858
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17859
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17860
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17861
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17862
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17863
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17864
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17865
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17866
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17867
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17868
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17869
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17870
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17871
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17872
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17873
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17874
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17875
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17876
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17877
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17878
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17879
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17880
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17881
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17882
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17883
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17884
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17885
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17886
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17887
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17888
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17889
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17890
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17891
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17892
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17893
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17894
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17895
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17896
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17897
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17898
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17899
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17900
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17901
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17902
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17903
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17904
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17905
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17906
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17907
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17908
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17909
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17910
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17911
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17912
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17913
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17914
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17915
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17916
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17917
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17918
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17919
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17920
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17921
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17922
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17923
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17924
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17925
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17926
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17927
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17928
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17929
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17930
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17931
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17932
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17933
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17934
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17935
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17936
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17937
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17938
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17939
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17940
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17941
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17942
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17943
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17944
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17945
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17946
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17947
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17948
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17949
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17950
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17951
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17952
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17953
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17954
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17955
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17956
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17957
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17958
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17959
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17960
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17961
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17962
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17963
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17964
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17965
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17966
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17967
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17968
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17969
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17970
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17971
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17972
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17973
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17974
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17975
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17976
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17977
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17978
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17979
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17980
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17981
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17982
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17983
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17984
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17985
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17986
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17987
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17988
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17989
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17990
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17991
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17992
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17993
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17994
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17995
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17996
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17997
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17998
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=17999
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18000
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18001
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18002
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18003
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18004
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18005
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18006
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18007
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18008
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18009
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18010
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18011
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18012
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18013
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18014
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18015
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18016
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18017
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18018
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18019
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18020
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18021
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18022
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18023
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18024
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18025
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18026
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18027
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18028
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18029
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18030
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18031
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18032
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18033
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18034
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18035
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18036
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18037
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18038
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18039
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18040
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18041
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18042
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18043
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18044
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18045
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18046
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18047
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18048
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18049
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18050
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18051
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18052
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18053
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18054
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18055
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18056
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18057
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18058
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18059
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18060
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18061
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18062
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18063
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18064
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18065
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18066
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18067
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18068
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18069
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18070
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18071
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18072
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18073
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18074
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18075
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18076
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18077
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18078
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18079
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18080
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18081
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18082
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18083
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18084
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18134
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18135
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18136
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18137
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18138
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18139
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18140
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18141
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18142
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18143
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18144
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18145
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18146
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18147
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18148
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18149
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18150
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18151
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18152
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18153
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18154
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18155
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18156
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18157
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18158
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18159
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18160
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18161
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18162
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18163
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18164
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18165
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18166
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18167
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18168
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18169
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18170
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18171
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18172
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18173
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18174
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18175
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18176
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18177
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18178
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18179
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18180
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18181
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18182
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18183
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18184
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18185
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18186
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18187
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18188
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18189
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18190
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18191
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18192
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18193
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18194
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18195
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18196
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18197
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18198
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18199
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18200
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18201
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18202
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18203
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18204
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18205
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18206
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18207
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18208
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18209
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18210
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18211
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18212
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18213
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18214
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18215
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18216
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18217
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18218
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18219
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18220
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18221
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18222
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18223
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18224
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18225
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18226
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18227
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18228
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18229
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18230
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18231
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18232
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18233
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18234
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18235
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18236
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18237
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18238
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18239
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18240
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18241
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18242
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18243
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18244
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18245
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18246
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18247
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18248
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18249
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18250
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18251
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18252
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18253
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18254
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18255
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18256
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18257
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18258
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18259
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18260
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18261
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18262
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18263
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18264
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18265
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18266
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18267
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18268
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18269
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18270
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18271
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18272
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18273
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18274
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18275
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18276
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18277
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18278
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18279
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18280
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18281
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18282
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18283
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18284
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18285
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18286
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18287
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18288
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18289
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18290
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18291
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18292
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18293
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18294
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18295
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18296
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18297
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18298
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18299
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18300
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18301
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18302
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18303
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18304
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18305
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18306
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18307
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18308
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18309
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18310
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18311
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18312
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18313
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18314
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18315
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18316
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18317
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18318
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18319
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18320
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18321
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18322
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18323
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18324
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18325
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18326
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18327
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18328
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18329
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18330
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18331
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18332
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18333
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18334
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18335
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18336
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18337
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18338
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18339
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18340
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18341
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18342
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18343
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18344
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18345
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18346
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18347
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18348
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18349
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18350
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18351
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18352
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18353
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18354
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18355
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18356
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18357
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18358
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18359
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18360
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18361
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18362
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18363
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18364
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18365
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18366
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18367
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18368
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18369
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18370
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18371
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18372
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18373
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18374
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18375
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18376
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18377
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18378
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18379
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18380
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18381
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18382
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18383
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18384
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18385
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18386
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18387
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18388
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18389
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18390
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18391
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18392
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18393
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18394
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18395
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18396
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18397
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18398
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18399
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18400
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18401
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18402
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18403
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18404
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18405
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18406
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18407
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18408
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18409
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18410
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18411
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18412
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18413
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18414
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18415
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18416
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18417
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18418
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18419
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18420
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18421
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18422
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18423
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18424
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18425
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18426
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18427
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18428
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18429
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18430
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18431
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18432
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18433
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18434
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18435
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18436
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18437
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18438
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18439
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18440
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18441
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18442
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18443
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18444
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18445
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18446
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18447
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18448
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18449
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18450
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18451
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18452
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18453
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18454
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18455
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18456
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18457
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18458
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18459
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18460
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18461
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18462
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18463
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18464
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18465
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18466
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18467
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18468
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18469
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18470
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18471
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18472
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18473
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18474
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18475
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18476
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18477
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18478
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18479
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18480
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18481
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18482
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18483
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18484
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18485
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18486
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18487
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18488
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18489
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18490
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18491
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18492
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18493
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18494
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18495
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18496
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18497
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18498
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18499
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18500
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18501
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18502
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18503
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18504
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18505
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18506
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18507
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18508
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18509
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18510
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18511
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18512
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18513
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18514
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18515
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18516
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18517
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18518
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18519
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18520
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18521
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18522
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18523
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18524
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18525
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18526
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18527
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18528
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18529
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18530
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18531
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18532
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18533
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18534
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18535
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18536
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18537
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18538
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18539
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18540
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18541
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18542
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18543
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18544
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18545
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18546
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18547
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18548
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18549
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18550
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18551
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18552
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18553
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18554
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18555
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18556
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18557
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18558
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18559
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18560
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18561
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18562
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18563
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18564
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18565
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18566
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18567
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18568
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18569
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18570
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18571
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18572
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18573
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18574
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18575
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18576
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18577
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18578
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18579
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18580
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18581
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18582
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18583
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18584
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18585
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18586
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18587
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18588
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18589
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18590
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18591
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18592
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18593
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18594
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18595
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18596
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18597
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18598
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18599
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18600
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18601
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18602
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18603
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18604
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18605
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18606
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18607
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18608
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18609
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18610
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18611
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18612
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18613
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18614
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18615
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18616
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18617
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18618
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18619
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18620
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18621
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18622
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18623
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18624
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18625
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18626
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18627
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18628
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18629
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18630
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18631
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18632
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18633
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18634
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18635
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18636
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18637
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18638
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18639
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18640
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18641
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18642
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18643
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18644
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18645
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18646
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18647
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18648
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18649
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18650
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18651
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18652
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18653
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18654
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18655
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18656
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18657
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18658
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18659
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18660
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18661
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18662
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18663
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18664
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18665
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18666
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18667
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18668
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18669
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18670
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18671
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18672
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18673
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18674
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18675
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18676
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18677
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18678
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18679
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18680
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18681
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18682
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18683
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18684
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18685
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18686
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18687
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18688
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18689
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18690
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18691
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18692
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18693
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18694
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18695
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18696
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18697
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18698
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18699
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18700
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18701
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18702
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18703
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18704
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18705
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18706
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18707
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18708
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18709
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18710
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18711
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18712
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18713
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18714
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18715
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18716
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18717
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18718
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18719
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18720
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18721
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18722
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18723
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18724
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18725
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18726
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18727
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18728
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18729
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18730
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18731
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18732
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18733
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18734
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18735
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18736
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18737
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18738
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18739
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18740
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18741
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18742
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18743
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18744
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18745
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18746
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18747
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18748
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18749
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18750
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18751
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18752
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18753
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18754
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18755
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18756
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18757
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18758
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18759
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18760
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18761
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18762
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18763
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18764
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18765
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18766
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18767
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18768
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18769
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18770
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18771
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18772
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18773
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18774
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18775
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18776
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18777
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18778
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18779
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18780
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18781
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18782
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18783
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18784
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18785
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18786
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18787
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18788
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18789
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18790
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18791
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18792
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18793
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18794
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18795
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18796
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18797
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18798
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18799
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18800
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18801
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18802
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18803
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18804
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18805
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18806
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18807
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18808
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18809
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18810
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18811
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18812
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18813
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18814
DELETE FROM [ERPSettings].[FunctionalityConfig] WHERE [Id]=18815
UPDATE [ERPSettings].[Functionality] SET [FR]=N'DELETE-RESERVEDDOCUMENTLINE_SA' WHERE [IdFunctionality]=N'0911caa7-8243-422b-b0d2-6e719a304f5e'
UPDATE [ERPSettings].[Functionality] SET [DefaultRoute]=N'/Salary' WHERE [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-177b4a3c8466'
UPDATE [ERPSettings].[Functionality] SET [DefaultRoute]=N'/Payroll' WHERE [IdFunctionality]=N'fd671f2f-5b90-4de3-9a07-207b4a3c8466'
GO
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] ON
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1, 11111, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2, 11111, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3, 11111, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4, 11111, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5, 11111, N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6, 11111, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7, 11111, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8, 11111, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (9, 11111, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (10, 11111, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (11, 11111, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (12, 11111, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (13, 11111, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (14, 11111, N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (15, 11111, N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (16, 11111, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (17, 11111, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (18, 11111, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (19, 11111, N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (20, 11111, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (21, 11111, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (22, 11111, N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (23, 11111, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (24, 11111, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (25, 11111, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (26, 11111, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (27, 11111, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (28, 11111, N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (29, 11111, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (30, 11111, N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (31, 11111, N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (32, 11111, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (33, 11111, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (34, 11111, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (35, 11111, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (36, 11111, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (37, 11111, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (38, 11111, N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (39, 11111, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (40, 11111, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (41, 11111, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (42, 11111, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (43, 11111, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (44, 11111, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (45, 11111, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (46, 11111, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (47, 11111, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (48, 11111, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (49, 11111, N'888c5233-b854-478e-b3e6-860eb288a09c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (50, 11111, N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (51, 11111, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (52, 11111, N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (53, 11111, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (54, 11111, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (55, 11111, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (56, 11111, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (57, 11111, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (58, 11111, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (59, 11111, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (60, 11111, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (61, 11111, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (62, 11111, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (63, 11111, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (64, 11111, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (65, 11111, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (66, 11111, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (67, 11111, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (68, 11111, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (69, 11111, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (70, 11111, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (71, 11111, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (72, 11111, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (73, 11111, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (74, 11111, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (75, 11111, N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (76, 11111, N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (77, 11111, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (78, 11111, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (79, 11111, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (80, 11111, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (81, 11111, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (82, 11111, N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (83, 11111, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (84, 11111, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (85, 11111, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (86, 11111, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (87, 11111, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (88, 11111, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (89, 11111, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (90, 11111, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (91, 11111, N'b8afa156-3522-420c-9118-c7fce2208fcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (92, 11111, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (93, 11111, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (94, 11111, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (95, 11111, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (96, 22222, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (97, 22222, N'504b7c8a-379b-45c7-9b44-6d825c30478b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (98, 22222, N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (99, 22222, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (100, 22222, N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (101, 22222, N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (102, 22222, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (103, 22222, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (104, 22222, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (105, 22222, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (106, 22222, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (107, 22222, N'2913a29a-35b4-4f14-9b4f-34c13879ef63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (108, 22222, N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (109, 22222, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (110, 22222, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (111, 22222, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (112, 22222, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (113, 22222, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (114, 22222, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (115, 22222, N'6079b54a-948a-4241-99a4-4af59b1a82c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (116, 22222, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (117, 22222, N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (118, 22222, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (119, 22222, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (120, 22222, N'bfc987ff-e9e0-4786-8bcf-557424b597b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (121, 22222, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (122, 22222, N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (123, 22222, N'a4eb7107-2ee3-421e-9271-816939a454d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (124, 22222, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (125, 22222, N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (126, 22222, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (127, 22222, N'98d525b7-49f0-407f-953f-a2eab399ce43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (128, 22222, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (129, 22222, N'da31dab8-5111-4a29-8fea-a8f893479229', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (130, 22222, N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (131, 22222, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (132, 22222, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (133, 22222, N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (134, 22222, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (135, 22222, N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (136, 22222, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (137, 22222, N'9fcc79e1-fe21-4415-ad86-c35fcd318638', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (138, 22222, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (139, 22222, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (140, 22222, N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (141, 22222, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (142, 22222, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (143, 22222, N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (144, 22222, N'46f3f410-4514-49a9-87fa-c79e653d17bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (145, 22222, N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (146, 22222, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (147, 22222, N'430759b9-c9c2-4d57-8812-94b07d8271c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (148, 22222, N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (149, 22222, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (150, 22222, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (151, 22222, N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (152, 22222, N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (153, 22222, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (154, 22222, N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (155, 22222, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (156, 22222, N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (157, 22222, N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (158, 22222, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (159, 22222, N'ac4698dc-57d6-4952-a284-e7120e4d7eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (160, 22222, N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (161, 22222, N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (162, 22222, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (163, 22222, N'6f08acda-f8d6-496a-920e-e440214aac79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (164, 22222, N'c4827784-0363-4114-9d98-2c7aad82fa02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (165, 22222, N'0b681d01-ff60-45e3-877b-f3b6e2e06553', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (166, 22222, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (167, 22222, N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (168, 22222, N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (169, 22222, N'c62e61c1-16ae-463c-8de8-fcc0516df031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (170, 22222, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (171, 22222, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (172, 22222, N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (173, 22222, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (174, 22222, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (175, 22222, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (176, 22222, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (177, 22222, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (178, 22222, N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (179, 22222, N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (180, 22222, N'299729a5-d7ed-4f30-a13c-1960d7374507', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (181, 22222, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (182, 22222, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (183, 22222, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (184, 22222, N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (185, 22222, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (186, 22222, N'd8559505-d792-4448-9389-11553df3a53b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (187, 22222, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (188, 22222, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (189, 22222, N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (190, 22222, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (191, 22222, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (192, 22222, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (193, 33333, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (194, 33333, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (195, 33333, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (196, 33333, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (197, 33333, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (198, 33333, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (199, 33333, N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (200, 33333, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (201, 33333, N'2e00c99b-cd88-41aa-8751-68402a23b014', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (202, 33333, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (203, 33333, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (204, 33333, N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (205, 33333, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (206, 33333, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (207, 33333, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (208, 33333, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (209, 33333, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (210, 33333, N'75c04415-a531-445e-a07d-289454bc7a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (211, 33333, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (212, 33333, N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (213, 33333, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (214, 33333, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (215, 33333, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (216, 33333, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (217, 33333, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (218, 33333, N'b0a20ad6-7b71-4d09-a25e-3e843f847335', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (219, 33333, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (220, 33333, N'cc05f689-5a26-4084-957f-468ffa646d39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (221, 33333, N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (222, 33333, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (223, 33333, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (224, 33333, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (225, 33333, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (226, 33333, N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (227, 33333, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (228, 33333, N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (229, 33333, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (230, 33333, N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (231, 33333, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (232, 33333, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (233, 33333, N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (234, 33333, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (235, 33333, N'f2715a17-ba0e-437b-a939-94382f648337', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (236, 33333, N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (237, 33333, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (238, 33333, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (239, 33333, N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (240, 33333, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (241, 33333, N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (242, 33333, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (243, 33333, N'44842db2-256f-4f1b-a668-aedb9e561a16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (244, 33333, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (245, 33333, N'71570f9c-c72a-4608-bf35-bb9adf44ef36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (246, 33333, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (247, 33333, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (248, 33333, N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (249, 33333, N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (250, 33333, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (251, 33333, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (252, 33333, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (253, 33333, N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (254, 33333, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (255, 33333, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (256, 33333, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (257, 33333, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (258, 33333, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (259, 33333, N'946982d0-e0c4-4c58-8959-c1731f793163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (260, 33333, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (261, 33333, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (262, 33333, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (263, 33333, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (264, 33333, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (265, 33333, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (266, 33333, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (267, 33333, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (268, 33333, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (269, 33333, N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (270, 33333, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (271, 33333, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (272, 33333, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (273, 33333, N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (274, 33333, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (275, 33333, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (276, 33333, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (277, 33333, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (278, 33333, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (279, 33333, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (280, 33333, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (281, 33333, N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (282, 33333, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (283, 33333, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (284, 33333, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (285, 33333, N'72595857-9760-4836-b5be-11c965e065f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (286, 33333, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (287, 33333, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (288, 33333, N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (289, 33333, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (290, 33333, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (291, 33333, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (292, 33333, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (293, 33333, N'd617ff97-654e-4788-add5-c28e90abe680', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (294, 33333, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (295, 33333, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (296, 33333, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (297, 33333, N'a6192524-3d69-4a52-a92c-c564fc1baec5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (298, 33333, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (299, 33333, N'2755658f-cb5e-41e9-8298-c97721bdba77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (300, 33333, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (301, 33333, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (302, 33333, N'603beed9-c3c3-46e1-8560-19706553c33c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (303, 33333, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (304, 33333, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (305, 44444, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (306, 44444, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (307, 44444, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (308, 44444, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (309, 44444, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (310, 44444, N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (311, 44444, N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (312, 44444, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (313, 44444, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (314, 44444, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (315, 44444, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (316, 44444, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (317, 44444, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (318, 44444, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (319, 44444, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (320, 44444, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (321, 44444, N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (322, 44444, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (323, 44444, N'26f81117-51f9-4638-aec4-801a6a296945', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (324, 44444, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (325, 44444, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (326, 44444, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (327, 44444, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (328, 77777, N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (329, 77777, N'0f288531-ba96-438f-b70d-5775de191ee2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (330, 77777, N'fb782972-bcd1-4f36-ba23-577b5e83363d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (331, 77777, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (332, 77777, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (333, 77777, N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (334, 77777, N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (335, 77777, N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (336, 77777, N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (337, 77777, N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (338, 77777, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (339, 77777, N'a17f6c5f-71a4-4086-af06-43926cf30080', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (340, 77777, N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (341, 77777, N'9ebcf470-1da4-4448-b8f5-41d5442849ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (342, 77777, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (343, 77777, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (344, 77777, N'376cbf30-280f-4ae0-af13-129d1cd02aca', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (345, 77777, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (346, 77777, N'6c104837-0a04-43d6-b200-177b98588522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (347, 77777, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (348, 77777, N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (349, 77777, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (350, 77777, N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (351, 77777, N'4653a3cf-5480-49a3-af52-1ede7d7a5432', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (352, 77777, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (353, 77777, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (354, 77777, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (355, 77777, N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (356, 77777, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (357, 77777, N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (358, 77777, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (359, 77777, N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (360, 77777, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (361, 77777, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (362, 77777, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (363, 77777, N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (364, 77777, N'7d159002-e21e-4829-87de-346273d5eccb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (365, 77777, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (366, 77777, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (367, 77777, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (368, 77777, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (369, 77777, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (370, 77777, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (371, 77777, N'8abd5fc1-be98-4340-bc15-25b76115782f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (372, 77777, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (373, 77777, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (374, 77777, N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (375, 77777, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (376, 77777, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (377, 77777, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (378, 77777, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (379, 77777, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (380, 77777, N'5fa827e8-96a8-4020-9153-8755f3c3de93', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (381, 77777, N'4248ba0b-646b-4525-a0a0-8713a10a608e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (382, 77777, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (383, 77777, N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (384, 77777, N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (385, 77777, N'1c753625-4561-4abf-aef9-7a92b01e481e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (386, 77777, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (387, 77777, N'418d053d-d730-4577-8e25-77584384703e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (388, 77777, N'183e2cc9-2522-4463-9366-775781dcb127', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (389, 77777, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (390, 77777, N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (391, 77777, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (392, 77777, N'cd30e343-60c3-4f7d-a566-72fe0718a90b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (393, 77777, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (394, 77777, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (395, 77777, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (396, 77777, N'66b8d9f8-6043-4d79-b960-9265da657a3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (397, 77777, N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (398, 77777, N'28e36f79-bac9-4340-a942-95dc9888c9d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (399, 77777, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (400, 77777, N'7bb9080b-247e-4a3d-b459-619677e19263', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (401, 77777, N'fc2da022-f055-48a0-9f91-643710950d43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (402, 77777, N'bb3c8465-744e-4995-b231-6714a5d25df9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (403, 77777, N'97795e35-e1f6-4d05-afe3-6773afb2d254', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (404, 77777, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (405, 77777, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (406, 77777, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (407, 77777, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (408, 77777, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (409, 77777, N'86894159-c1f3-44ab-bddc-a578289077a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (410, 77777, N'e7b3084b-711a-43e3-8ab6-a37af089281e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (411, 77777, N'0356eb50-3f15-4843-88ea-a130922a1ced', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (412, 77777, N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (413, 77777, N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (414, 77777, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (415, 77777, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (416, 77777, N'1fc23099-0aff-4d52-be49-9cbcba9405ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (417, 77777, N'e5a6ccba-20d6-47db-b131-9c564f67a361', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (418, 77777, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (419, 77777, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (420, 77777, N'5fb337a9-70ec-46e2-a53e-9824ae05fd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (421, 77777, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (422, 77777, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (423, 77777, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (424, 77777, N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (425, 77777, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (426, 77777, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (427, 77777, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (428, 77777, N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (429, 77777, N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (430, 77777, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (431, 77777, N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (432, 77777, N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (433, 77777, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (434, 77777, N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (435, 77777, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (436, 77777, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (437, 77777, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (438, 77777, N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (439, 77777, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (440, 77777, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (441, 77777, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (442, 77777, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (443, 77777, N'776d3e4e-c68b-43c3-a5a3-f91385bd6296', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (444, 77777, N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (445, 77777, N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (446, 77777, N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (447, 77777, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (448, 77777, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (449, 77777, N'5f376240-3764-4733-a269-aad8b2f2b886', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (450, 77777, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (451, 77777, N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (452, 77777, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (453, 77777, N'72ab7a79-351b-4893-8b79-d4d03fa39b4b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (454, 77777, N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (455, 77777, N'41328f04-b725-4435-837b-082e169aea31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (456, 77777, N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (457, 77777, N'd8f89701-7006-48e9-b2ec-0679551a0418', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (458, 77777, N'51c504b7-3fd2-4111-9652-05b295f0732f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (459, 77777, N'04564a71-cc75-4d65-934f-03d6598429df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (460, 77777, N'af5d4af2-8810-4ba1-a628-003796357bfb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (461, 77777, N'249ba7d6-26bc-43df-b75d-b568252cc2c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (462, 77777, N'd604fb47-2f09-4a36-8ccc-b697fcbf3205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (463, 77777, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (464, 77777, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (465, 77777, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (466, 77777, N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (467, 77777, N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (468, 77777, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (469, 77777, N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (470, 77777, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (471, 77777, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (472, 77777, N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (473, 77777, N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (474, 77777, N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (475, 77777, N'1370af42-416b-4af5-8416-d274643cc31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (476, 77777, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (477, 77777, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (478, 77777, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (479, 77777, N'7541f25b-34db-4ad5-a8ae-09d1dd558706', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (480, 77777, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (481, 88888, N'104d522c-cab9-4916-be40-62e7c00de59c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (482, 88888, N'4d7fa507-2170-425e-96f0-f42822ff6311', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (483, 88888, N'4c5b37fd-34d7-4148-9c84-1ab08be35e14', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (484, 88888, N'49bc61be-8c43-4854-9d06-b61ae3118a92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (485, 88888, N'57302d72-6ffb-4f7c-a191-11e00c17b4ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (486, 88888, N'3bdfce52-fe6a-4886-a070-ce2b9445927f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (487, 88888, N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (488, 88888, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (489, 88888, N'd87ce1b0-b82f-4927-8ef4-cee2b7d54d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (490, 88888, N'd32b919b-6b19-4548-af32-5854f6d795fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (491, 88888, N'413143f0-12c1-4787-85e3-683d02a3fbd0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (492, 88888, N'16353f67-23c3-4cf9-9a88-16eaa18f10d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (493, 88888, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (494, 88888, N'f4ae521c-e52a-4e36-a13d-7d238dab1469', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (495, 88888, N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (496, 88888, N'195f5149-f23f-468b-8cf6-c85390bb28f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (497, 88888, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (498, 88888, N'8bd4017e-1b0e-432c-97cb-8b13bf6274fd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (499, 88888, N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (500, 88888, N'94329f27-c3bd-45ab-8e06-60e4a0199878', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (501, 88888, N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (502, 100000, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (503, 100000, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (504, 100000, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (505, 100000, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (506, 100000, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (507, 100000, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (508, 100000, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (509, 100000, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (510, 100000, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (511, 100000, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (512, 100000, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (513, 100000, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (514, 100000, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (515, 100000, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (516, 100000, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (517, 100000, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (518, 100000, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (519, 100000, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (520, 100000, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (521, 100000, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (522, 100000, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (523, 100000, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (524, 100000, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (525, 100000, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (526, 100000, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (527, 100000, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (528, 100000, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (529, 100000, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (530, 100000, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (531, 100000, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (532, 100000, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (533, 100000, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (534, 100000, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (535, 100000, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (536, 100000, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (537, 100000, N'14096ba7-324e-4092-b933-a1b57c3ebb32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (538, 100000, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (539, 100000, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (540, 100000, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (541, 100000, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (542, 100000, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (543, 100000, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (544, 100000, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (545, 100000, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (546, 100000, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (547, 100000, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (548, 100000, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (549, 100000, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (550, 100000, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (551, 100000, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (552, 100000, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (553, 100000, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (554, 100000, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (555, 100000, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (556, 100000, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (557, 100000, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (558, 100000, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (559, 100000, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (560, 100000, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (561, 100000, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (562, 100000, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (563, 100000, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (564, 100000, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (565, 100000, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (566, 100000, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (567, 100000, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (568, 100000, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (569, 100000, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (570, 100001, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (571, 100001, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (572, 100001, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (573, 100001, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (574, 100001, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (575, 100001, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (576, 100001, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (577, 100001, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (578, 100001, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (579, 100001, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (580, 100001, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (581, 100001, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (582, 100001, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (583, 100001, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (584, 100001, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (585, 100001, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (586, 100001, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (587, 100001, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (588, 100001, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (589, 100001, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (590, 100001, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (591, 100001, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (592, 100001, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (593, 100001, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (594, 100001, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (595, 100001, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (596, 100001, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (597, 100001, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (598, 100001, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (599, 100001, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (600, 100001, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (601, 100001, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (602, 100001, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (603, 100001, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (604, 100001, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (605, 100001, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (606, 100001, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (607, 100001, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (608, 100001, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (609, 100001, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (610, 100001, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (611, 100001, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (612, 100001, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (613, 100001, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (614, 100001, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (615, 100001, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (616, 100001, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (617, 100001, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (618, 100001, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (619, 100001, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (620, 100001, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (621, 100001, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (622, 100001, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (623, 100001, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (624, 100001, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (625, 100001, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (626, 100001, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (627, 100001, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (628, 100001, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (629, 100001, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (630, 100001, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (631, 100001, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (632, 100001, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (633, 100001, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (634, 100001, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (635, 100001, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (636, 100001, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (637, 100001, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (638, 100001, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (639, 100001, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (640, 100001, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (641, 100001, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (642, 100001, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (643, 100001, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (644, 100001, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (645, 100001, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (646, 100001, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (647, 100001, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (648, 100001, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (649, 100001, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (650, 100001, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (651, 100001, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (652, 100001, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (653, 100001, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (654, 100001, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (655, 100001, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (656, 100001, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (657, 100001, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (658, 100001, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (659, 100001, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (660, 100001, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (661, 100001, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (662, 100001, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (663, 100001, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (664, 100001, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (665, 100001, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (666, 100001, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (667, 100001, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (668, 100001, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (669, 100001, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (670, 100001, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (671, 100001, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (672, 100001, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (673, 100001, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (674, 100001, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (675, 100001, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (676, 100001, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (677, 100001, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (678, 100001, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (679, 100001, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (680, 100001, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (681, 100001, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (682, 100001, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (683, 100001, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (684, 100001, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (685, 100001, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (686, 100001, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (687, 100001, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (688, 100001, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (689, 100001, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (690, 100001, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (691, 100001, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (692, 100001, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (693, 100001, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (694, 100001, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (695, 100001, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (696, 100001, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (697, 100001, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (698, 100001, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (699, 100001, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (700, 100001, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (701, 100001, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (702, 100001, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (703, 100001, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (704, 100001, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (705, 100001, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (706, 100001, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (707, 100001, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (708, 100001, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (709, 100001, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (710, 100001, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (711, 100001, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (712, 100001, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (713, 100001, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (714, 100001, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (715, 100001, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (716, 100001, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (717, 100001, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (718, 100001, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (719, 100001, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (720, 100001, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (721, 100001, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (722, 100001, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (723, 100001, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (724, 100001, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (725, 100001, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (726, 100001, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (727, 100001, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (728, 100001, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (729, 100001, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (730, 100001, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (731, 100001, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (732, 100001, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (733, 100001, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (734, 100002, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (735, 100002, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (736, 100002, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (737, 100002, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (738, 100002, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (739, 100002, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (740, 100002, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (741, 100002, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (742, 100002, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (743, 100002, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (744, 100002, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (745, 100002, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (746, 100002, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (747, 100002, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (748, 100002, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (749, 100002, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (750, 100002, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (751, 100002, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (752, 100002, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (753, 100002, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (754, 100002, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (755, 100002, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (756, 100002, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (757, 100002, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (758, 100002, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (759, 100002, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (760, 100002, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (761, 100002, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (762, 100002, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (763, 100002, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (764, 100002, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (765, 100002, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (766, 100002, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (767, 100002, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (768, 100002, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (769, 100002, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (770, 100002, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (771, 100002, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (772, 100002, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (773, 100002, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (774, 100002, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (775, 100002, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (776, 100002, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (777, 100002, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (778, 100002, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (779, 100002, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (780, 100002, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (781, 100002, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (782, 100002, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (783, 100002, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (784, 100002, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (785, 100002, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (786, 100002, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (787, 100002, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (788, 100002, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (789, 100002, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (790, 100002, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (791, 100002, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (792, 100002, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (793, 100002, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (794, 100002, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (795, 100002, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (796, 100002, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (797, 100002, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (798, 100002, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (799, 100002, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (800, 100002, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (801, 100002, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (802, 100002, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (803, 100002, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (804, 100002, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (805, 100002, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (806, 100002, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (807, 100002, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (808, 100002, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (809, 100002, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (810, 100002, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (811, 100002, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (812, 100002, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (813, 100002, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (814, 100002, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (815, 100002, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (816, 100002, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (817, 100002, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (818, 100002, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (819, 100002, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (820, 100002, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (821, 100002, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (822, 100002, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (823, 100002, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (824, 100002, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (825, 100002, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (826, 100002, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (827, 100002, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (828, 100002, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (829, 100002, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (830, 100002, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (831, 100002, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (832, 100002, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (833, 100002, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (834, 100002, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (835, 100002, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (836, 100002, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (837, 100002, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (838, 100002, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (839, 100002, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (840, 100002, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (841, 100002, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (842, 100002, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (843, 100002, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (844, 100002, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (845, 100002, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (846, 100002, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (847, 100002, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (848, 100002, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (849, 100002, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (850, 100002, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (851, 100002, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (852, 100002, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (853, 100002, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (854, 100002, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (855, 100002, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (856, 100002, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (857, 100002, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (858, 100002, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (859, 100002, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (860, 100002, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (861, 100002, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (862, 100002, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (863, 100002, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (864, 100002, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (865, 100002, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (866, 100002, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (867, 100002, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (868, 100002, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (869, 100002, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (870, 100002, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (871, 100002, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (872, 100002, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (873, 100002, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (874, 100002, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (875, 100002, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (876, 100002, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (877, 100002, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (878, 100002, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (879, 100002, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (880, 100002, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (881, 100002, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (882, 100002, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (883, 100002, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (884, 100002, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (885, 100002, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (886, 100002, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (887, 100002, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (888, 100002, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (889, 100002, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (890, 100002, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (891, 100002, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (892, 100002, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (893, 100002, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (894, 100002, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (895, 100002, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (896, 100002, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (897, 100002, N'5472cf06-def0-4062-95df-6c6abb535288', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (898, 100002, N'33fc3fb8-f12b-40af-acfa-be21fddbd790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (899, 100002, N'41eabde8-52de-4c93-895e-afdd95ada7dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (900, 100002, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (986, 100004, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (987, 100004, N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (988, 100005, N'e21a8021-5299-4845-b534-fd1f3c46ab69', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (989, 11111, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (990, 11111, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (991, 11111, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (992, 11111, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (993, 11111, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (994, 11111, N'1d587003-8abd-4e4c-a096-5fa386feb25e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (995, 100006, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (996, 100006, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (997, 100006, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (998, 100006, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (999, 100006, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1005, 90000, N'826ce05a-530f-4174-803c-a16f47ce3582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1006, 90000, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1007, 90000, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1008, 90000, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1009, 90000, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1010, 90000, N'3bdfce52-fe6a-4886-a070-ce2b9445927f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1011, 90000, N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1012, 90000, N'413143f0-12c1-4787-85e3-683d02a3fbd0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1013, 90000, N'1fc23099-0aff-4d52-be49-9cbcba9405ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1014, 90000, N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1015, 90000, N'1370af42-416b-4af5-8416-d274643cc31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1016, 90000, N'6079b54a-948a-4241-99a4-4af59b1a82c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1017, 90000, N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1018, 90000, N'183e2cc9-2522-4463-9366-775781dcb127', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1019, 90000, N'af5d4af2-8810-4ba1-a628-003796357bfb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1020, 90000, N'be0964a9-1fe6-4049-9fdc-254c8094b267', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1021, 90000, N'f12d6dde-f573-4a78-b960-91cfeeb56643', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1022, 90000, N'a7310087-e271-40ea-ae49-60d76ede699c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1023, 90000, N'7fb3352a-87e4-41e8-b5d8-7cb1207ccb6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1024, 90000, N'3d20bc90-5f3e-4b46-99a2-387d3ecd10bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1025, 90000, N'df9634bb-01c2-41a9-a8a9-57a5c25f5bd4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1026, 90000, N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1027, 90000, N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1028, 90000, N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1029, 90000, N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1030, 90000, N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1031, 90000, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1032, 90000, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1033, 90000, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1034, 90000, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1035, 90000, N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1036, 90000, N'e7b3084b-711a-43e3-8ab6-a37af089281e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1037, 90000, N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1038, 90000, N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1039, 90000, N'1c753625-4561-4abf-aef9-7a92b01e481e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1040, 90000, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1041, 90000, N'4248ba0b-646b-4525-a0a0-8713a10a608e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1042, 90000, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1043, 90000, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1044, 90000, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1045, 90000, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1046, 90000, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1047, 90000, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1048, 90000, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1049, 90000, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1050, 90000, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1051, 90000, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1052, 90000, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1053, 90000, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1054, 90000, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1055, 90000, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1056, 90000, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1057, 90000, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1058, 90000, N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1059, 90000, N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1060, 90000, N'2913a29a-35b4-4f14-9b4f-34c13879ef63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1061, 90000, N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1062, 90000, N'98d525b7-49f0-407f-953f-a2eab399ce43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1063, 90000, N'd8559505-d792-4448-9389-11553df3a53b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1064, 90000, N'b365a596-61f0-4ada-bc56-f455b9d56c51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1065, 90000, N'2eefeed5-3995-4dd4-83fa-603c440faba3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1066, 90000, N'3820fb92-f9bb-4c15-9a7f-279f97c68184', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1067, 90000, N'819b148d-a655-41e4-a030-6b0dfc006694', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1068, 90000, N'eb75b4cc-b859-40b2-b126-426faf885a6a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1069, 90000, N'97682275-a556-4232-9c34-a4b7ea15ed81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1070, 90000, N'7614e74e-e5d1-4ed0-b9b1-42676b17930a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1071, 90000, N'128ce50b-5f62-443f-96b1-3b4351542998', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1072, 90000, N'cc494a21-2fbe-4871-83b7-c0dbb19fbe5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1073, 90000, N'bc03c3e4-f361-4150-9dc5-53b253af072c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1074, 90000, N'245ecc4a-fa91-44af-a51b-25d312f09006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1075, 90000, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1076, 90000, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1077, 90000, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1078, 90000, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1079, 90000, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1080, 90000, N'7bb9080b-247e-4a3d-b459-619677e19263', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1081, 90000, N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1082, 90000, N'104d522c-cab9-4916-be40-62e7c00de59c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1083, 90000, N'4c5b37fd-34d7-4148-9c84-1ab08be35e14', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1084, 90000, N'49bc61be-8c43-4854-9d06-b61ae3118a92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1085, 90000, N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1086, 90000, N'4d7fa507-2170-425e-96f0-f42822ff6311', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1087, 90000, N'57302d72-6ffb-4f7c-a191-11e00c17b4ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1088, 90000, N'94329f27-c3bd-45ab-8e06-60e4a0199878', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1089, 90000, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1090, 90000, N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1091, 90000, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1092, 90000, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1093, 90000, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1094, 90000, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1095, 90000, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1096, 90000, N'3eb1157c-852d-43ea-a65f-7073e3897613', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1097, 90000, N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1098, 90000, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1099, 90000, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1100, 90000, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1101, 90000, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1102, 90000, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1103, 90000, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1104, 90000, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1105, 90000, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1106, 90000, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1107, 90000, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1108, 90000, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1109, 90000, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1110, 90000, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1111, 90000, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1112, 90000, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1113, 90000, N'a1ca4007-d64e-4765-af61-42e753a61222', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1114, 90000, N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1115, 90000, N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1116, 90000, N'd7c9f718-49fb-41e3-88a5-0197b286cd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1117, 90000, N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1118, 90000, N'12e2ecc5-d861-4680-9310-92422a3e2593', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1119, 90000, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1120, 90000, N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1121, 90000, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1122, 90000, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1123, 90000, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1124, 90000, N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1125, 90000, N'5fb337a9-70ec-46e2-a53e-9824ae05fd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1126, 90000, N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1127, 90000, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1128, 90000, N'bb3c8465-744e-4995-b231-6714a5d25df9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1129, 90000, N'8c874f57-c8bf-4239-96b0-a220ae4937cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1130, 90000, N'40e9ae6c-edc9-4a5a-89dd-7d9ccc8fa9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1131, 90000, N'3eb50693-0eb2-4050-b399-60591a44e130', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1132, 90000, N'd6eff940-0b49-4710-8cf6-dae5e168744d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1133, 90000, N'f69539b5-5133-4052-83f1-789cf707be89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1134, 90000, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1135, 90000, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1136, 90000, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1137, 90000, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1138, 90000, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1139, 90000, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1140, 90000, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1141, 90000, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1142, 90000, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1143, 90000, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1144, 90000, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1145, 90000, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1146, 90000, N'ee347789-32ce-492c-a380-99eef0467543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1147, 90000, N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1148, 90000, N'324079a9-3676-4d46-9704-b6a7a707101e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1149, 90000, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1150, 90000, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1151, 90000, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1152, 90000, N'54aac154-2c0a-471c-adfd-0469a65737cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1153, 90000, N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1154, 90000, N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1155, 90000, N'4b7535a4-dd2e-4071-9080-09a340e427f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1156, 90000, N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1157, 90000, N'c71757fa-088e-4b46-9359-455061d6b753', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1158, 90000, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1159, 90000, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1160, 90000, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1161, 90000, N'34492beb-def2-4437-97a8-7afa138e17c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1162, 90000, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1163, 90000, N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1164, 90000, N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1165, 90000, N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1166, 90000, N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1167, 90000, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1168, 90000, N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1169, 90000, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1170, 90000, N'c196270b-56d8-4eaa-8c52-69773420797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1171, 90000, N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1172, 90000, N'a5adefe0-da79-4d63-b90a-7aead7d7ed32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1173, 90000, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1174, 90000, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1175, 90000, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1176, 90000, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1177, 90000, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1178, 90000, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1179, 90000, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1180, 90000, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1181, 90000, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1182, 90000, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1183, 90000, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1184, 90000, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1185, 90000, N'ee347789-32ce-492c-a380-99eef0467543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1186, 90000, N'ffc49b57-0fb4-4c4a-90a5-e05fecf51551', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1187, 90000, N'324079a9-3676-4d46-9704-b6a7a707101e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1188, 90000, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1189, 90000, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1190, 90000, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1191, 90000, N'54aac154-2c0a-471c-adfd-0469a65737cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1192, 90000, N'd2ac2b71-9dcd-4cd7-a2cb-9e93f28ce529', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1193, 90000, N'0c9c378f-5cb0-422f-a8f3-b5bd8e915789', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1194, 90000, N'4b7535a4-dd2e-4071-9080-09a340e427f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1195, 90000, N'29132ca2-1891-40bd-96d3-7dcf4a2bb816', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1196, 90000, N'c71757fa-088e-4b46-9359-455061d6b753', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1197, 90000, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1198, 90000, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1199, 90000, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1200, 90000, N'34492beb-def2-4437-97a8-7afa138e17c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1201, 90000, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1202, 90000, N'f6b1ec86-245f-425d-a557-18c8fbc38f9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1203, 90000, N'7f678f9a-efc1-408f-8ab4-45db3d9ec4a6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1204, 90000, N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1205, 90000, N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1206, 90000, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1207, 90000, N'84f4a21b-0c62-4a11-a48b-7f682c46bd7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1208, 90000, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1209, 90000, N'c196270b-56d8-4eaa-8c52-69773420797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1210, 90000, N'557d9bc9-16b2-4dc9-a9a2-5c4f9ea01cc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1211, 90000, N'1c4dd748-6f03-430a-9d07-9b84e6a0902e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1212, 90000, N'41adc77a-62e3-4a81-8a90-c565ea54fcce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1213, 90000, N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1214, 90000, N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1215, 90000, N'a97affbe-b4da-40f6-8055-f493cef4d9e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1216, 90000, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1217, 90000, N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1218, 90000, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1219, 90000, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1220, 90000, N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1221, 90000, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1222, 90000, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1223, 90000, N'21f017a7-a1ec-48a0-8749-e3c71beb1ac4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1224, 90000, N'a291e34e-5db0-4835-bad7-f88cc7d5d3aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1225, 90000, N'fde2b73a-2fff-49b2-8f7f-6cb1c15fdaa1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1226, 90000, N'605f60cb-09e8-41c6-9ba4-829679b00c84', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1227, 90000, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1228, 90000, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1229, 90000, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1230, 90000, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1231, 90000, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1232, 90000, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1233, 90000, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1234, 90000, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1235, 90000, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1236, 90000, N'8c5d84fa-a6a5-4f0c-8aee-bdd432d8aa66', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1237, 90000, N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1238, 90000, N'73dbb6fc-0ffd-4e7c-af10-291c35cb4a46', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1239, 90000, N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1240, 90000, N'07d35985-0229-40c3-aaed-0fce364b33c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1241, 90000, N'b8cfb588-5071-4035-9e0f-f7f14f2856e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1242, 90000, N'9a7e6cfe-cd60-4ccd-8c14-af283303e936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1243, 90000, N'a3ea8642-aa44-45f4-9b53-060b114819e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1244, 90000, N'7eac8530-e743-4028-9434-48f8ba9a09ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1245, 90000, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1246, 90000, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1247, 90000, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1248, 90000, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1249, 90000, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1250, 90000, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1251, 90000, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1252, 90000, N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1253, 90000, N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1254, 90000, N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1255, 90000, N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1256, 90000, N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1257, 90000, N'7de70953-05e2-4e44-85dd-5853dd4d2cb8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1258, 90000, N'1ba293b9-8bde-4a86-a6a9-efc5753af567', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1259, 90000, N'788872dc-bdd0-4558-b3c8-37af3fda8a42', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1260, 90000, N'a682c7d3-6e4e-421b-815b-b55711c24a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1261, 90000, N'820ab0ac-6d35-4a42-a051-cd9f986d9c09', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1262, 90000, N'95adccad-66f9-47b3-a471-a6ee737b67a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1263, 90000, N'14096ba7-324e-4092-b933-a1b57c3ebb32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1264, 90000, N'0354f894-5ad4-4667-8c78-e85416e88313', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1265, 90000, N'af6ec62f-06d0-4188-8022-5e0a64dc6186', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1266, 90000, N'23d69255-7c68-459f-8f3e-b19bdf4e1498', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1267, 90000, N'cb4545fb-c741-428f-87eb-afee3bf38e7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1268, 90000, N'fd671f2f-5b90-4de3-9a07-19ab4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1269, 90000, N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1270, 90000, N'0356eb50-3f15-4843-88ea-a130922a1ced', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1271, 90000, N'41328f04-b725-4435-837b-082e169aea31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1272, 90000, N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1273, 90000, N'5f376240-3764-4733-a269-aad8b2f2b886', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1274, 90000, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1275, 90000, N'138aaaf8-73c6-489d-91e3-55d5724cfbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1276, 90000, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1277, 90000, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1278, 90000, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1279, 90000, N'4902b1fc-d541-4288-85c4-5fec5a8840f6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1280, 90000, N'e987f370-b8d6-4dbd-9836-8b0dbeba8542', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1281, 90000, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1282, 90000, N'21804bc7-8dbb-4558-ad03-83640ef3aa7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1283, 90000, N'f4f4474e-03e3-46f7-bbdb-58244e1ae3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1284, 90000, N'e217064d-adff-4afc-af38-7dede030d53f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1285, 90000, N'05d28c92-aa4b-459f-a306-ea45722c9e71', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1286, 90000, N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1287, 90000, N'da43d379-0954-42dd-9832-8890747a0929', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1288, 90000, N'076aa20b-5f04-4872-8093-40cef7ee2e1d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1289, 90000, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1290, 90000, N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1291, 90000, N'1b99e1a1-fcf9-4573-ad6d-8dbedaf9fe21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1292, 90000, N'3cb5935b-0589-4634-9eeb-3cd416bf67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1293, 90000, N'c28598d5-f067-4f50-85fa-1f727fc56de8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1294, 90000, N'9ba6f025-144f-416a-9497-2f556c27e278', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1295, 90000, N'50af6a35-1bc4-4a1c-ae95-da5c5ce99279', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1296, 90000, N'de313b3e-a99d-409e-bc43-546d11247a8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1297, 90000, N'5935921f-8dea-4799-baf8-2a1520e50204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1298, 90000, N'654e8915-5ec5-4c80-aea1-376390d10dd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1299, 90000, N'5883e2f9-d14e-4b50-9652-7894bcc15590', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1300, 90000, N'246c4f30-4c7b-460b-aebb-5d713455b050', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1301, 90000, N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1302, 90000, N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1303, 90000, N'71570f9c-c72a-4608-bf35-bb9adf44ef36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1304, 90000, N'72595857-9760-4836-b5be-11c965e065f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1305, 90000, N'29ca49a1-4bf6-4116-b7d3-fc4fceec9d94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1306, 90000, N'20e787cc-6bb6-4115-8177-1712dffa737a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1307, 90000, N'a3494b24-c859-499c-8125-831b7f159320', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1308, 90000, N'dc9dbbba-3388-45e8-97a0-a9b2b2971aa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1309, 90000, N'8a10f075-1614-4019-8d64-28a9a5d21ce8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1310, 90000, N'd7786c13-ea07-4f22-9046-f2a04f1e03e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1311, 90000, N'83dc878d-7bba-4609-94c2-d01745a05fa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1312, 90000, N'5dd0709b-1712-4a50-8c6e-91ef9ca6a547', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1313, 90000, N'7ed2a3e9-87e4-4d30-88e2-4f268fde3257', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1314, 90000, N'63d0f2e0-7ba5-42fd-99d4-ebd6cac5c0bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1315, 90000, N'6645f540-88c9-478a-96ec-bee746bc67e4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1316, 90000, N'1e14b590-ffeb-436f-bc88-20585a055247', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1317, 90000, N'3a4f5627-0b8a-45d5-8095-3cb43c8d3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1318, 90000, N'c7035a5e-7d19-4041-93e6-11dec3d4ae79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1319, 90000, N'9c490860-14ee-44e1-8f5f-080587e317ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1320, 90000, N'6b41e424-e45d-4b74-9bd4-b8f001f2b6ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1321, 90000, N'1cb5efa9-81fb-4ed7-a330-a14322057cf3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1322, 90000, N'44842db2-256f-4f1b-a668-aedb9e561a16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1323, 90000, N'75c04415-a531-445e-a07d-289454bc7a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1324, 90000, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1325, 90000, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1326, 90000, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1327, 90000, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1328, 90000, N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1329, 90000, N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1330, 90000, N'ac4698dc-57d6-4952-a284-e7120e4d7eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1331, 90000, N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1332, 90000, N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1333, 90000, N'6f08acda-f8d6-496a-920e-e440214aac79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1334, 90000, N'47725902-0b42-4a59-b6c5-dd30fd303c2a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1335, 90000, N'f72cabe4-9301-4aa0-b7db-3a926095f2b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1336, 90000, N'8f7756c1-64d5-4328-accb-1f683d92ccf0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1337, 90000, N'47ffe987-86af-4fe5-9d13-9ace5ac76e87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1338, 90000, N'063b1ba2-64c0-440f-bb1e-7068355531fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1339, 90000, N'364d8d09-1818-42d4-9b9a-fbfda35ca4fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1340, 90000, N'45e921f2-079a-457c-aeea-6e8a96dd153d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1341, 90000, N'e4765a60-289d-4a38-bcff-fffb5b0e2c17', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1342, 90000, N'881ebe14-f1e1-4b80-96a6-5bde2824eca3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1343, 90000, N'56cc7835-fb1d-4107-8d13-5d28ca0dd104', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1344, 90000, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1345, 90000, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1346, 90000, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1347, 90000, N'5fa827e8-96a8-4020-9153-8755f3c3de93', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1348, 90000, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1349, 90000, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1350, 90000, N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1351, 90000, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1352, 90000, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1353, 90000, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1354, 90000, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1355, 90000, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1356, 90000, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1357, 90000, N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1358, 90000, N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1359, 90000, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1360, 90000, N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1361, 90000, N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1362, 90000, N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1363, 90000, N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1364, 90000, N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1365, 90000, N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1366, 90000, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1367, 90000, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1368, 90000, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1369, 90000, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1370, 90000, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1371, 90000, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1372, 90000, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1373, 90000, N'9fcc79e1-fe21-4415-ad86-c35fcd318638', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1374, 90000, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1375, 90000, N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1376, 90000, N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1377, 90000, N'be1a5270-9d9f-409d-988e-e573128abf8a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1378, 90000, N'adf1350d-f7c9-41fb-bd15-6d3eba1b75de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1379, 90000, N'996c01cf-3f6a-4c7c-a5a0-fa862548e351', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1380, 90000, N'0927c339-ed6b-482f-ab49-15e3ef8e57a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1381, 90000, N'd131e823-79fb-48ac-827f-bb105e830abe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1382, 90000, N'df67df5f-8b20-47aa-9e3d-dcbd094b29ed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1383, 90000, N'90e4a6e5-d159-4193-b7e9-cdcd8698bee3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1384, 90000, N'b7e5861f-9d7b-4b68-a07c-258c29f04d2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1385, 90000, N'4256493c-98b6-4a0e-9ba8-89ce04de832d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1386, 90000, N'e29d1e20-fb42-47a3-8315-0af62753b0ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1387, 90000, N'abfa596e-2286-4024-90dc-b8cb507a96f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1388, 90000, N'b31317ba-1511-4be8-8778-e741d2803d16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1389, 90000, N'fc9a7981-5c09-4fca-8885-fc1582ddf6a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1390, 90000, N'6f45141c-d00b-4cd0-85c9-0a3a4e1d911b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1391, 90000, N'44606826-3f05-44b7-a790-85527f1e8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1392, 90000, N'cdd7db9d-6929-4539-ae3f-2363bf449f73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1393, 90000, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1394, 90000, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1395, 90000, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1396, 90000, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1397, 90000, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1398, 90000, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1399, 90000, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1400, 90000, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1401, 90000, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1402, 90000, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1403, 90000, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1404, 90000, N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1405, 90000, N'418d053d-d730-4577-8e25-77584384703e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1406, 90000, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1407, 90000, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1408, 90000, N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1409, 90000, N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1410, 90000, N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1411, 90000, N'd8f89701-7006-48e9-b2ec-0679551a0418', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1412, 90000, N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1413, 90000, N'cd30e343-60c3-4f7d-a566-72fe0718a90b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1414, 90000, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1415, 90000, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1416, 90000, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1417, 90000, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1418, 90000, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1419, 90000, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1420, 90000, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1421, 90000, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1422, 90000, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1423, 90000, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1424, 90000, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1425, 90000, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1426, 90000, N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1427, 90000, N'195f5149-f23f-468b-8cf6-c85390bb28f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1428, 90000, N'16353f67-23c3-4cf9-9a88-16eaa18f10d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1429, 90000, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1430, 90000, N'66b8d9f8-6043-4d79-b960-9265da657a3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1431, 90000, N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1432, 90000, N'7541f25b-34db-4ad5-a8ae-09d1dd558706', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1433, 90000, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1434, 90000, N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1435, 90000, N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1436, 90000, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1437, 90000, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1438, 90000, N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1439, 90000, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1440, 90000, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1441, 90000, N'7d64bd68-b90c-413c-a3e6-981183d49bdc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1442, 90000, N'9019037e-b18e-4b83-98dd-d9590a10670c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1443, 90000, N'94381ea1-15ea-4559-a9c7-cf6ddb53ec40', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1444, 90000, N'7cdb9b56-0bfb-4c75-b87d-a777709c203f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1445, 90000, N'8d30ee0f-9dba-47cd-a84c-4fd9fa771d0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1446, 90000, N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1447, 90000, N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1448, 90000, N'bfc987ff-e9e0-4786-8bcf-557424b597b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1449, 90000, N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1450, 90000, N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1451, 90000, N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1452, 90000, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1453, 90000, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1454, 90000, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1455, 90000, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1456, 90000, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1457, 90000, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1458, 90000, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1459, 90000, N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1460, 90000, N'fb782972-bcd1-4f36-ba23-577b5e83363d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1461, 90000, N'72ae0c99-4cb9-4d56-809a-041e55579963', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1462, 90000, N'6cb718c8-8069-4549-95e2-fec340984b81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1463, 90000, N'aab63718-55f6-4c84-9d96-40b74f4ae92b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1464, 90000, N'129bda36-163a-4c8f-8e65-2a3fdf2e862d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1465, 90000, N'78154c09-d1eb-4ae7-b395-bc67e79adf6e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1466, 90000, N'8f9f3349-5c0d-4569-b561-0b67dd1dff01', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1467, 90000, N'cc619a78-e398-4032-9ccd-000cb48a4bf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1468, 90000, N'55809876-8109-4bd2-a655-ab0996fb54c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1469, 90000, N'2676ade9-b20a-485d-be49-f5f839e90b7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1470, 90000, N'17f7318a-98ec-4124-9b94-3d0413720163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1471, 90000, N'7112ab0c-75f0-4237-8b59-1e6a1ea54a97', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1472, 90000, N'db45eee0-9d96-4482-ba46-a082b2090cd5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1473, 90000, N'6904af6a-266d-4422-9e50-bac6b512cb6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1474, 90000, N'b5216afc-d33d-46f3-b7db-a4170912d7c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1475, 90000, N'ab0d83dd-e6be-45a5-9f20-014500cbc3f8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1476, 90000, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1477, 90000, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1478, 90000, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1479, 90000, N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1480, 90000, N'c62e61c1-16ae-463c-8de8-fcc0516df031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1481, 90000, N'504b7c8a-379b-45c7-9b44-6d825c30478b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1482, 90000, N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1483, 90000, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1484, 90000, N'c1d44620-a496-4de0-895f-56066017a16f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1485, 90000, N'bf56f348-0a33-4ac2-ae63-5822a62a2123', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1486, 90000, N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1487, 90000, N'a6192524-3d69-4a52-a92c-c564fc1baec5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1488, 90000, N'560c0361-0321-4690-a9b9-1391cb9d6451', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1489, 90000, N'8403df7d-3348-400b-9946-f9f86614a4dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1490, 90000, N'2b2d022d-370e-4b7e-9271-b1f694ed8c4c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1491, 90000, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1492, 90000, N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1493, 90000, N'422f1608-e641-4ec1-9163-636bb3c6962b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1494, 90000, N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1495, 90000, N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1496, 90000, N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1497, 90000, N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1498, 90000, N'06eb3687-d016-4597-9538-c1eaed785b50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1499, 90000, N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1500, 90000, N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1501, 90000, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1502, 90000, N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1503, 90000, N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1504, 90000, N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1505, 90000, N'04564a71-cc75-4d65-934f-03d6598429df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1506, 90000, N'0f288531-ba96-438f-b70d-5775de191ee2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1507, 90000, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1508, 90000, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1509, 90000, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1510, 90000, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1511, 90000, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1512, 90000, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1513, 90000, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1514, 90000, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1515, 90000, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1516, 90000, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1517, 90000, N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1518, 90000, N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1519, 90000, N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1520, 90000, N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1521, 90000, N'25803ebb-f8d0-4058-ae1d-29e742224932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1522, 90000, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1523, 90000, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1524, 90000, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1525, 90000, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1526, 90000, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1527, 90000, N'6d1006f2-51ab-4aba-abc6-b597f28b1603', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1528, 90000, N'4ad09cf5-9247-4970-9616-6e36bb2a40a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1529, 90000, N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1530, 90000, N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1531, 90000, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1532, 90000, N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1533, 90000, N'81dfe010-14a0-48a7-aa0d-48023d967286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1534, 90000, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1535, 90000, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1536, 90000, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1537, 90000, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1538, 90000, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1539, 90000, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1540, 90000, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1541, 90000, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1542, 90000, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1543, 90000, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1544, 90000, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1545, 90000, N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1546, 90000, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1547, 90000, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1548, 90000, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1549, 90000, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1550, 90000, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1551, 90000, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1552, 90000, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1553, 90000, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1554, 90000, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1555, 90000, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1556, 90000, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1557, 90000, N'e21a8021-5299-4845-b534-fd1f3c46ab69', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1558, 90000, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1559, 90000, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1560, 90000, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1561, 90000, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1562, 90000, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1563, 90000, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1564, 90000, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1565, 90000, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1566, 90000, N'dec4c280-cc66-4fbf-8317-4a3d70a234fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1567, 90000, N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1568, 90000, N'3e160c8e-b2f6-45f1-8ab2-8f4c036573e1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1569, 90000, N'273b5a2d-455f-47f9-8bc9-913953c3a161', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1570, 90000, N'afc3feb8-7935-4901-817b-9ae97bfd2744', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1571, 90000, N'ceeacfe2-8f90-47e9-845f-63a34e3de4bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1572, 90000, N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1573, 90000, N'a69984ec-f11f-46aa-9b32-9d22d815fd4c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1574, 90000, N'3683ddae-8093-4d4e-ab44-ce435c7a4eef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1575, 90000, N'31e012f0-2bdf-4a15-a3c5-6daa98927d21', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1576, 90000, N'f737ca1b-5aed-4093-a49e-cc6a77cbcb79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1577, 90000, N'b4f8506d-ae3f-452e-807f-bf1be20f362d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1578, 90000, N'01df57f4-8853-47c1-812b-6837444c4971', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1579, 90000, N'cce5f23e-1760-4144-9637-2522ea80d1d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1580, 90000, N'b43a16a1-05d0-4bc6-b62a-3149be561b7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1581, 90000, N'179b7471-6f14-44c3-8b65-9fcaacb1372a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1582, 90000, N'97050a68-9699-4bda-bb74-bac15ac8ceef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1583, 90000, N'a2aa875a-6bcd-46cd-9845-aa51274725d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1584, 90000, N'3a396a34-e1f0-4c47-93db-394bc5f4c557', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1585, 90000, N'7c0f7cd0-65b7-4c4a-a6b7-95fe64d35522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1586, 90000, N'5ac44e48-a3ec-4540-881b-4a664c551900', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1587, 90000, N'c77023f5-3d29-4643-90b1-ede9b9a56ca4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1588, 90000, N'101453c8-09ce-417c-8951-6a91dca67f26', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1589, 90000, N'719f8bd7-f502-4e43-b184-88cc17302d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1590, 90000, N'0a677b95-72a2-4192-8c44-a3a4127a32bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1591, 90000, N'df89bf72-79fe-434b-8245-bd50b2aee9f5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1592, 90000, N'20813979-2589-4e31-8357-96b066fd0c56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1593, 90000, N'356798c9-66ab-43aa-8a18-31f9927dfc87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1594, 90000, N'31b38c08-2611-4142-a024-87fdcc8d3eea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1595, 90000, N'fdd09e03-8cfe-4c43-85ae-4b96e406b075', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1596, 90000, N'7bef86b3-a3c3-4b8d-b4d0-72aa4f0d6afe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1597, 90000, N'796c9178-0921-4ed9-84e3-bacd804cc649', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1598, 90000, N'050cbe2c-f0af-4b59-ac45-557a0e8594cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1599, 90000, N'c525df86-f303-4e6d-9344-8f1424aad695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1600, 90000, N'1f1cc7de-14bd-4929-ae91-f1fe6573a428', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1601, 90000, N'7fd50f16-1e45-491a-b1c7-daa5f72e3366', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1602, 90000, N'd782bfa7-8bbc-452f-a908-e8c84710524e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1603, 90000, N'9e3275da-93b7-465f-baa8-732e630e5038', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1604, 90000, N'8d4a7e7e-4955-4fbd-b1a9-266fca77fc3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1605, 90000, N'912d2d30-2f02-4620-9dc0-31c06f3d0c16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1606, 90000, N'eb46cbd9-8754-422b-84e0-b9347db7cce5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1607, 90000, N'7b24e760-fa91-4bc3-acf2-cd2140f8b938', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1608, 90000, N'4499f362-059e-4a4a-8e99-f1bef76afffc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1609, 90000, N'70736180-c459-451b-aa23-3e119ba56137', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1610, 90000, N'8dc53087-5dcb-4027-b092-8e257280e75a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1611, 90000, N'ae99aa0c-146f-4b4f-81d2-a95fb077a367', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1612, 90000, N'7b1e7ccb-fd1e-4271-b7b3-5f8d5efb5cec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1613, 90000, N'a6204969-3848-412d-80e1-c596eb740f36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1614, 90000, N'249ba7d6-26bc-43df-b75d-b568252cc2c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1615, 90000, N'a17f6c5f-71a4-4086-af06-43926cf30080', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1616, 90000, N'336fdb14-6186-41c2-b2ff-98c99ea25c5f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1617, 90000, N'05d45e13-6184-4085-b9b2-86015af49e11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1618, 90000, N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1619, 90000, N'712d6299-495e-45ce-9010-20e4ad36834a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1620, 90000, N'11ab7a69-a705-4f46-8821-9bb3b7815a98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1621, 90000, N'831becf0-0744-4fe4-b79c-dec135cee846', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1622, 90000, N'a6c247bc-d584-43a3-b995-f303e3b13c77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1623, 90000, N'be512744-b639-4f8a-ab84-e7f568ff5289', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1624, 90000, N'f2715a17-ba0e-437b-a939-94382f648337', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1625, 90000, N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1626, 90000, N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1627, 90000, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1628, 90000, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1629, 90000, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1630, 90000, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1631, 90000, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1632, 90000, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1633, 90000, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1634, 90000, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1635, 90000, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1636, 90000, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1637, 90000, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1638, 90000, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1639, 90000, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1640, 90000, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1641, 90000, N'cff23ad0-4ab0-4ee3-87d5-9a5ee10f5996', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1642, 90000, N'1d300971-3288-4683-808f-a24867cf8ff1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1643, 90000, N'65f51079-a03f-4d49-879a-d14fdfd94f7f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1644, 90000, N'68e42e81-caa8-4bae-a742-847aecef1d34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1645, 90000, N'fdd7676a-860c-471d-a102-fa4cb1ccbe0f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1646, 90000, N'26f81117-51f9-4638-aec4-801a6a296945', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1647, 90000, N'114535ed-507b-48dd-8a35-bbdc252a82a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1648, 90000, N'a36dadb4-a0e3-4a10-a52d-24273c131af1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1649, 90000, N'273e5d24-26ed-4c78-9de1-6ac406b3529a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1650, 90000, N'f885c6a4-cf1e-4ca9-8bd2-5e1ec8e75310', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1651, 90000, N'1828f13e-34a3-43c4-8dd5-28b1e86b83e7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1652, 90000, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1653, 90000, N'de36105a-564c-478d-ad54-a9c6e64db410', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1654, 90000, N'df7e2b4d-01f0-44d6-a7d6-8337225897c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1655, 90000, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1656, 90000, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1657, 90000, N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1658, 90000, N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1659, 90000, N'e31fdfff-824c-4a7d-a640-8f43a6c4f824', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1660, 90000, N'6c104837-0a04-43d6-b200-177b98588522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1661, 90000, N'cc715473-7abd-4b07-8458-a07daaca6e15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1662, 90000, N'a66523be-f0b3-4420-aea5-ecba26c130be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1663, 90000, N'dc736454-3856-4968-9662-4c1800a85f4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1664, 90000, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1665, 90000, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1666, 90000, N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1667, 90000, N'17100aba-2fde-4a45-9e1c-4cf93f3b2248', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1668, 90000, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1669, 90000, N'26236d58-2ef6-493d-a936-3bb2a1efc1a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1670, 90000, N'fb07746a-f1b1-43f6-823f-643fb9100df1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1671, 90000, N'aa016aeb-2fda-4e56-83ce-6286ab21c128', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1672, 90000, N'72319cbf-8bef-4b52-b422-b77ffbcc1b2b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1673, 90000, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1674, 90000, N'946982d0-e0c4-4c58-8959-c1731f793163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1675, 90000, N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1676, 90000, N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1677, 90000, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1678, 90000, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1679, 90000, N'86de038f-e73a-4cf8-9d0c-3c488130396e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1680, 90000, N'fdc96a50-12cd-46db-9007-16ae4d4342e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1681, 90000, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1682, 90000, N'1fbce248-8b99-4a9e-8273-ae5eb5b2a9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1683, 90000, N'cfe0c82c-fea3-4932-ae45-9aadf1fe019f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1684, 90000, N'd482c274-39ec-4dad-a850-fc692fb38c62', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1685, 90000, N'0c10d809-c6ce-4b4d-8bfe-cfe646b71d73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1686, 90000, N'234ca81d-87b9-43a3-a215-2908500fb7c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1687, 90000, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1688, 90000, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1689, 90000, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1690, 90000, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1691, 90000, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1692, 90000, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1693, 90000, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1694, 90000, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1695, 90000, N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1696, 90000, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1697, 90000, N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1698, 90000, N'd617ff97-654e-4788-add5-c28e90abe680', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1699, 90000, N'48ae5050-184c-44e4-861e-d256272b207d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1700, 90000, N'aee4bc17-1442-48b2-a95b-3ec265c58cd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1701, 90000, N'ee9c1fd5-1738-481d-9072-c64b51a4fd9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1702, 90000, N'5069d2f1-0dbe-4d29-ae69-130d560901c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1703, 90000, N'faff4451-6454-4dff-b4a9-6168f1edf526', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1704, 90000, N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1705, 90000, N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1706, 90000, N'376cbf30-280f-4ae0-af13-129d1cd02aca', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1707, 90000, N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1708, 90000, N'966e921f-2d1b-4475-a540-87edecfb27ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1709, 90000, N'7d159002-e21e-4829-87de-346273d5eccb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1710, 90000, N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1711, 90000, N'7e97bd9c-d247-4d24-97aa-cafc8535848d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1712, 90000, N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1713, 90000, N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1714, 90000, N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1715, 90000, N'51c504b7-3fd2-4111-9652-05b295f0732f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1716, 90000, N'299729a5-d7ed-4f30-a13c-1960d7374507', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1717, 90000, N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1718, 90000, N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1719, 90000, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1720, 90000, N'0b681d01-ff60-45e3-877b-f3b6e2e06553', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1721, 90000, N'a4eb7107-2ee3-421e-9271-816939a454d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1722, 90000, N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1723, 90000, N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1724, 90000, N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1725, 90000, N'430759b9-c9c2-4d57-8812-94b07d8271c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1726, 90000, N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1727, 90000, N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1728, 90000, N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1729, 90000, N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1730, 90000, N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1731, 90000, N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1732, 90000, N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1733, 90000, N'c4827784-0363-4114-9d98-2c7aad82fa02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1734, 90000, N'da31dab8-5111-4a29-8fea-a8f893479229', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1735, 90000, N'0233afff-931a-48cc-86d9-c8a83b415efa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1736, 90000, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1737, 90000, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1738, 90000, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1739, 90000, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1740, 90000, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1741, 90000, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1742, 90000, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1743, 90000, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1744, 90000, N'2e00c99b-cd88-41aa-8751-68402a23b014', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1745, 90000, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1746, 90000, N'b0a20ad6-7b71-4d09-a25e-3e843f847335', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1747, 90000, N'4653a3cf-5480-49a3-af52-1ede7d7a5432', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1748, 90000, N'9ebcf470-1da4-4448-b8f5-41d5442849ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1749, 90000, N'fc2da022-f055-48a0-9f91-643710950d43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1750, 90000, N'72ab7a79-351b-4893-8b79-d4d03fa39b4b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1751, 90000, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1752, 90000, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1753, 90000, N'28e36f79-bac9-4340-a942-95dc9888c9d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1754, 90000, N'33fc3fb8-f12b-40af-acfa-be21fddbd790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1755, 90000, N'41eabde8-52de-4c93-895e-afdd95ada7dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1756, 90000, N'b8b11a00-55a8-4238-ba74-6c7a1c66155f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1757, 90000, N'39aa31cd-4781-402d-a3ff-3c142a22d932', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1758, 90000, N'5472cf06-def0-4062-95df-6c6abb535288', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1759, 90000, N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1760, 90000, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1761, 90000, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1762, 90000, N'6b61765e-ea61-4c76-939c-6ae9cc1de26a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1763, 90000, N'ee642289-11eb-4bf4-96d7-d29cf86f8af5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1764, 90000, N'be5d4975-be9a-498f-865d-d07f06ff89cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1765, 90000, N'1337d415-a395-4c6f-8e50-3353d2144358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1766, 90000, N'6d09cea6-5736-4f72-87da-cb10b8c7f7b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1767, 90000, N'be9a0ee8-d035-454f-9fd8-981126b40901', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1768, 90000, N'8b899c93-d247-416c-a2e3-1fd4f82ffb72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1769, 90000, N'14fb7dc4-a72d-4a71-bbb4-f72cc51f815b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1770, 90000, N'4be00617-89d5-4d42-bdf0-cc3f2ea9ad78', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1771, 90000, N'73b2bfbd-8cfc-4211-b027-629ca2a98e16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1772, 90000, N'5931328a-4842-4a55-ab4a-4ecc135dc411', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1773, 90000, N'091cdee7-2d1d-4ce7-a78c-259f714f4fbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1774, 90000, N'ed815f54-f12c-4a06-90a0-883367d6ae5e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1775, 90000, N'12900316-455b-457e-9608-99bd7784b5b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1776, 90000, N'338293ba-7779-49e3-84b9-5129e4595976', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1777, 90000, N'0b100835-2d9f-4822-988d-8398825d890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1778, 90000, N'05b91908-5bf4-4bdd-a308-0e265b1a3eb1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1779, 90000, N'77ecfd18-7fc5-43fa-b4d1-41e00441716d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1780, 90000, N'81be47a9-267e-46db-b29f-176d78feb76c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1781, 90000, N'2e273d46-f310-4045-b71c-b3d030366786', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1782, 90000, N'1aebf541-0e2c-4bc5-b831-7e279c18e07f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1783, 90000, N'b1872538-a731-457c-b014-c9724c5f400a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1784, 90000, N'b1b04e81-9891-4d43-b0ea-1082b1946c1c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1785, 90000, N'c4c58629-cb0f-4677-92c4-0b996bc3e9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1786, 90000, N'e7f1b097-aa16-4324-876e-9fa2346c4c1d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1787, 90000, N'7768e6b6-f89a-479d-8d78-37d17a7337a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1788, 90000, N'df35e021-6ac4-47ef-ae79-622eee46118a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1789, 90000, N'84cb4ba1-c6b6-4bfe-a3be-8b13ca958607', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1790, 90000, N'1be65a49-42aa-4b69-ae86-3e338a534397', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1791, 90000, N'4ab8a098-0fd4-49d1-b3b4-257cc77e6bde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1792, 90000, N'87d5550c-243f-464e-b840-538984cdbcd3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1794, 90000, N'd166dfdd-0289-40ad-af71-bf2ef8d92de7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1795, 90000, N'59e39e77-7e34-402b-9cb7-1e5979851a45', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1796, 90000, N'4c4456b1-e25a-450b-b8ed-f1754b052cf2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1797, 90000, N'8604a88c-4e5b-4f8b-80f6-80d2e64a1173', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1798, 90000, N'23c296a6-c18d-476a-9a90-dfee961b3e91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1799, 90000, N'9ab63ad6-398c-433e-8bde-bea519eccb9b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1800, 90000, N'1c185dc5-ffc3-4c5a-8b57-999f0ec1b8d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1801, 90000, N'a0df3ec7-881e-47d4-bb76-7f1750945bb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1802, 90000, N'58383b7d-21a0-408b-9a20-227754aed94a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1803, 90000, N'e9853c97-1317-4cd0-a65a-80d46b3e6f0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1804, 90000, N'e7e18cc9-29ef-499d-a303-20c78c9c612d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1805, 90000, N'c8a6739e-bf26-4f95-b5ec-39910ab21619', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1806, 90000, N'96764174-5f40-462c-a27d-33da5e1370b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1807, 90000, N'0723db00-80a1-4125-855d-499d87c4ac90', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1808, 90000, N'b46bf40d-dd79-4cb7-9109-606b26d7f2a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1809, 90000, N'7ab868d2-7df9-43f4-ad8c-7db411841503', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1810, 90000, N'8f1efa25-37cd-46b1-9f19-ca227c793d8b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1811, 90000, N'e7503523-4b3e-4562-9a4f-b7ed827b9a29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1812, 90000, N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1813, 90000, N'8ae23626-4c5f-4cfb-abe9-d33c2150991b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1814, 90000, N'a869f004-0ee9-4bfd-9986-7248355c6052', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1815, 90000, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1816, 90000, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1817, 90000, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1818, 90000, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1819, 90000, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1820, 90000, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1821, 90000, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1822, 90000, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1823, 90000, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1824, 90000, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1825, 90000, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1826, 90000, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1827, 90000, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1828, 90000, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1829, 90000, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1830, 90000, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1831, 90000, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1832, 90000, N'8f1efa25-37cd-46b1-9f19-ca227c793d8b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1833, 90000, N'e7503523-4b3e-4562-9a4f-b7ed827b9a29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1834, 90000, N'ad3b4e11-f8f0-40e8-81df-5eb61bcb04dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1835, 90000, N'8ae23626-4c5f-4cfb-abe9-d33c2150991b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1836, 90000, N'a869f004-0ee9-4bfd-9986-7248355c6052', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1837, 90000, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1838, 90000, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1839, 90000, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1840, 90000, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1841, 90000, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1842, 90000, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1843, 90000, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1844, 90000, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1845, 90000, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1846, 90000, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1847, 90000, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1848, 90000, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1849, 90000, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1850, 90000, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1851, 90000, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1852, 90000, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1853, 90000, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1854, 90000, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1855, 90000, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1856, 90000, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1857, 90000, N'776d3e4e-c68b-43c3-a5a3-f91385bd6296', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1858, 90000, N'd87ce1b0-b82f-4927-8ef4-cee2b7d54d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1859, 90000, N'8bd4017e-1b0e-432c-97cb-8b13bf6274fd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1860, 90000, N'f4ae521c-e52a-4e36-a13d-7d238dab1469', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1861, 90000, N'e5a6ccba-20d6-47db-b131-9c564f67a361', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1862, 90000, N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1863, 90000, N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1864, 90000, N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1865, 90000, N'8abd5fc1-be98-4340-bc15-25b76115782f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1866, 90000, N'cb81ff12-6d18-4566-8f70-8d78e483b9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1867, 90000, N'97795e35-e1f6-4d05-afe3-6773afb2d254', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1868, 90000, N'd32b919b-6b19-4548-af32-5854f6d795fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1869, 90000, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1870, 90000, N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1871, 101016, N'a5adefe0-da79-4d63-b90a-7aead7d7ed32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1872, 70002, N'fd671f2f-5b90-4de3-9a07-157b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1873, 70003, N'fd671f2f-5b90-4de3-9a07-167b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1874, 70013, N'fd671f2f-5b22-4de3-9a07-777b4a3c8522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1875, 70005, N'fd671f2f-5b90-4de3-9a07-187b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1876, 70006, N'fd671f2f-5b90-4de3-9a07-197b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1877, 70012, N'fd671f2f-5b55-4de3-9a07-617b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1878, 70008, N'fd671f2f-5b90-4de3-9a07-217b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1879, 70009, N'fd671f2f-5b90-4de3-9a07-227b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1880, 70010, N'fd671f2f-5b90-4de3-9a07-237b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1881, 101016, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1882, 101016, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1883, 101016, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1884, 101016, N'f40d9aec-9f39-4e4b-a73d-6fcec5f73c32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1885, 101016, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1886, 101016, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1887, 101016, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1888, 101016, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1889, 101016, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1890, 101016, N'a94a17a2-60ed-4bde-a307-22787ea95b96', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1891, 101016, N'3bf5cebc-d59d-4938-895d-3ec5bf19361c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1892, 101016, N'e1b2d981-9d9a-4073-a0b4-64e41ebe3fd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1893, 101016, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1894, 101016, N'24fb6bff-bf88-4367-a5be-7a9180304283', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1895, 101016, N'5bcce21a-e711-4fb9-abf6-a199cf8b1774', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1896, 101016, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1897, 101016, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1898, 101016, N'20de167f-fde4-4fa3-a154-edb87e97bf73', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1899, 101016, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1900, 101016, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1901, 101016, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1902, 101016, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1903, 101016, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (1904, 101016, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2982, 11111, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2983, 11111, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2984, 11111, N'32b3ded2-309f-4d49-91a5-5cacdcd94a8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2985, 11111, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2986, 11111, N'ba5f3438-1464-4ae6-9a24-6a1122ece8e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2987, 11111, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2988, 11111, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2989, 11111, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2990, 11111, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2991, 11111, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2992, 11111, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2993, 11111, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2994, 11111, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2995, 11111, N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2996, 11111, N'd5367ad3-b1cf-4b50-903c-3c0750fd4fd6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2997, 11111, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2998, 11111, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (2999, 11111, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3000, 11111, N'abcefd5e-e78c-4a77-b9b9-51be6b54dc04', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3001, 11111, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3002, 11111, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3003, 11111, N'1cbbf6be-5a06-40dc-92e4-53fe961d4c3f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3004, 11111, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3005, 11111, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3006, 11111, N'5afe23dd-03a4-4857-b96d-55b011b9af72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3007, 11111, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3008, 11111, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3009, 11111, N'94c2b980-d3eb-4c1f-99a4-83aad0b9b9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3010, 11111, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3011, 11111, N'95d8b8b2-0db0-40dd-b521-933b3be1b5ba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3012, 11111, N'8172fa8f-9ff5-475e-8d92-93fc731091eb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3013, 11111, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3014, 11111, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3015, 11111, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3016, 11111, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3017, 11111, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3018, 11111, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3019, 11111, N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3020, 11111, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3021, 11111, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3022, 11111, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3023, 11111, N'b0503a12-05ee-4c0b-aeff-a90cbd09962c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3024, 11111, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3025, 11111, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3026, 11111, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3027, 11111, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3028, 11111, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3029, 11111, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3030, 11111, N'888c5233-b854-478e-b3e6-860eb288a09c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3031, 11111, N'ecd91131-4e0f-4db6-9bcf-85c887427136', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3032, 11111, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3033, 11111, N'fa2cd4b9-aa3d-4d3b-bbec-810703bf4f8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3034, 11111, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3035, 11111, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3036, 11111, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3037, 11111, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3038, 11111, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3039, 11111, N'288e8c5c-d015-4000-a5f8-2c2aac406922', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3040, 11111, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3041, 11111, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3042, 11111, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3043, 11111, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3044, 11111, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3045, 11111, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3046, 11111, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3047, 11111, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3048, 11111, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3049, 11111, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3050, 11111, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3051, 11111, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3052, 11111, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3053, 11111, N'e608e4c5-cf0e-4511-8d2a-f7b10d76f1ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3054, 11111, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3055, 11111, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3056, 11111, N'56c04a6d-e806-4e8a-9c38-f0c7335b9566', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3057, 11111, N'e0490245-3f54-4720-b7c0-d36591f5ffed', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3058, 11111, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3059, 11111, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3060, 11111, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3061, 11111, N'bb95f2a9-8ee5-415e-8b24-2447e6ba4dcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3062, 11111, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3063, 11111, N'd0c98e91-0f98-4c94-ae86-1ef2e128f975', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3064, 11111, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3065, 11111, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3066, 11111, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3067, 11111, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3068, 11111, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3069, 11111, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3070, 11111, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3071, 11111, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3072, 11111, N'b8afa156-3522-420c-9118-c7fce2208fcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3073, 11111, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3074, 11111, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3075, 11111, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3076, 11111, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3077, 11111, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3078, 11111, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3079, 11111, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3080, 11111, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3081, 11111, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3082, 11111, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3083, 11111, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3084, 11111, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3085, 11111, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3086, 11111, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3087, 11111, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3088, 11111, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3089, 11111, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3090, 11111, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3091, 11111, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3092, 11111, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3093, 11111, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3094, 11111, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3095, 11111, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3096, 11111, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3097, 11111, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3098, 11111, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3099, 11111, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3100, 11111, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3101, 11111, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3102, 11111, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3103, 11111, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3104, 11111, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3105, 22222, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3106, 22222, N'504b7c8a-379b-45c7-9b44-6d825c30478b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3107, 22222, N'905f69a3-b01f-4171-b4e7-6f52ef9398e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3108, 22222, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3109, 22222, N'aeda0d9e-bf64-4ccf-ab7b-7a39098b90d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3110, 22222, N'e17f7b49-5da8-4c2d-84b7-7ad8314435be', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3111, 22222, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3112, 22222, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3113, 22222, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3114, 22222, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3115, 22222, N'2913a29a-35b4-4f14-9b4f-34c13879ef63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3116, 22222, N'e96efc5b-0b85-42c0-abf3-373ad2869879', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3117, 22222, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3118, 22222, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3119, 22222, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3120, 22222, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3121, 22222, N'c5a223f3-5d06-455a-8c50-65ad56f7059b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3122, 22222, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3123, 22222, N'6079b54a-948a-4241-99a4-4af59b1a82c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3124, 22222, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3125, 22222, N'5f8edfc1-9a82-4a9d-82fc-518ba8cc92d3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3126, 22222, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3127, 22222, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3128, 22222, N'bfc987ff-e9e0-4786-8bcf-557424b597b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3129, 22222, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3130, 22222, N'ae961c2e-8ca8-4d43-8c3d-47275caecaf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3131, 22222, N'a4eb7107-2ee3-421e-9271-816939a454d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3132, 22222, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3133, 22222, N'a0c35796-bc6a-452c-a8f2-865ae862cb82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3134, 22222, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3135, 22222, N'98d525b7-49f0-407f-953f-a2eab399ce43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3136, 22222, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3137, 22222, N'da31dab8-5111-4a29-8fea-a8f893479229', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3138, 22222, N'ca492c4c-42b2-4493-9f5a-b58b96cac09f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3139, 22222, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3140, 22222, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3141, 22222, N'8cb7c2ed-bd94-4e84-a44c-bd44c426a131', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3142, 22222, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3143, 22222, N'a19d1e72-1307-47b2-bfcb-c0d88e4df9b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3144, 22222, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3145, 22222, N'9fcc79e1-fe21-4415-ad86-c35fcd318638', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3146, 22222, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3147, 22222, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3148, 22222, N'14a69e0b-0a07-4178-bc83-c5c9f2e663ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3149, 22222, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3150, 22222, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3151, 22222, N'edb8d08c-ea9a-4d55-be32-c69ce4ccae07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3152, 22222, N'46f3f410-4514-49a9-87fa-c79e653d17bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3153, 22222, N'48c4b04c-59db-43d5-baba-9b750f1d3951', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3154, 22222, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3155, 22222, N'430759b9-c9c2-4d57-8812-94b07d8271c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3156, 22222, N'eee4960b-0beb-4758-a5df-9488b9e90a1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3157, 22222, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3158, 22222, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3159, 22222, N'b5662ca1-736e-421c-b228-8b6dd972fdec', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3160, 22222, N'15ed05a6-b2c6-4486-8c8d-c4ec9312f29e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3161, 22222, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3162, 22222, N'bd804d71-4b02-4995-9cfe-d1ff82793a05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3163, 22222, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3164, 22222, N'86971979-71d1-47a5-9006-e4e4c74c6a65', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3165, 22222, N'd1d56bae-a0b7-46af-a1ae-e56e2cd6c09b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3166, 22222, N'01bdc9eb-8f37-4b28-96f5-e661259e9291', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3167, 22222, N'ac4698dc-57d6-4952-a284-e7120e4d7eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3168, 22222, N'a243e6ff-a7d4-4ae9-ab1e-e73b5e704705', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3169, 22222, N'71faed82-43c3-41ce-a5a4-e77b6649d459', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3170, 22222, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3171, 22222, N'6f08acda-f8d6-496a-920e-e440214aac79', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3172, 22222, N'c4827784-0363-4114-9d98-2c7aad82fa02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3173, 22222, N'0b681d01-ff60-45e3-877b-f3b6e2e06553', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3174, 22222, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3175, 22222, N'92c5486b-f76f-4253-be9a-f679b5aaf461', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3176, 22222, N'cb97cb0d-d670-4d87-95d4-f85457d7170a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3177, 22222, N'c62e61c1-16ae-463c-8de8-fcc0516df031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3178, 22222, N'78dfa306-e1a5-4530-9be4-fea0cc1cc31f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3179, 22222, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3180, 22222, N'092d0e85-b9bc-4464-813c-f256ea284c7d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3181, 22222, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3182, 22222, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3183, 22222, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3184, 22222, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3185, 22222, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3186, 22222, N'edb67248-51cb-46d3-99c7-1c6c50ff82e8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3187, 22222, N'419838f7-f353-4ee5-9e90-1acbc0e94db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3188, 22222, N'299729a5-d7ed-4f30-a13c-1960d7374507', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3189, 22222, N'a0fa8cb4-a958-4237-87c0-194c59f15a0c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3190, 22222, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3191, 22222, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3192, 22222, N'ad8575c0-72ca-40cc-bf54-135ac2026501', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3193, 22222, N'1cdd12ee-254f-4cae-9299-129c1c9651d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3194, 22222, N'd8559505-d792-4448-9389-11553df3a53b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3195, 22222, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3196, 22222, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3197, 22222, N'4c9aeef0-3ab6-44cc-ba0b-d8ff8bd75ce7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3198, 22222, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3199, 22222, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3200, 22222, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3201, 22222, N'42819f8c-a780-4532-938c-a48b3ab28c8c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3202, 33333, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3203, 33333, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3204, 33333, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3205, 33333, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3206, 33333, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3207, 33333, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3208, 33333, N'a37f20d2-67a0-49d2-81d5-5fefad6f7882', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3209, 33333, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3210, 33333, N'2e00c99b-cd88-41aa-8751-68402a23b014', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3211, 33333, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3212, 33333, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3213, 33333, N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3214, 33333, N'4956ffa4-3f8b-4993-bda1-5860eab524aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3215, 33333, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3216, 33333, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3217, 33333, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3218, 33333, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3219, 33333, N'75c04415-a531-445e-a07d-289454bc7a18', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3220, 33333, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3221, 33333, N'58a85ed9-603e-48f7-b7a3-2c1a83f7323e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3222, 33333, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3223, 33333, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3224, 33333, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3225, 33333, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3226, 33333, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3227, 33333, N'b0a20ad6-7b71-4d09-a25e-3e843f847335', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3228, 33333, N'4e9fe8bd-ecbd-4bfe-bc50-427c92dece80', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3229, 33333, N'cc05f689-5a26-4084-957f-468ffa646d39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3230, 33333, N'54a5eb28-f2b7-460b-a21c-4a552dfc6d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3231, 33333, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3232, 33333, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3233, 33333, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3234, 33333, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3235, 33333, N'b2faf601-15d4-4282-bac4-7214dc4a23f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3236, 33333, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3237, 33333, N'8d9995a6-cb05-4e26-8ac6-7fe15e4fe88e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3238, 33333, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3239, 33333, N'1a5ad493-2aa3-4b33-9f27-810da7376dbe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3240, 33333, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3241, 33333, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3242, 33333, N'22286879-b923-4b86-b2e3-8e9d973c9f6f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3243, 33333, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3244, 33333, N'f2715a17-ba0e-437b-a939-94382f648337', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3245, 33333, N'c9ff88bb-1b08-47a4-92ac-963b8b8c3908', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3246, 33333, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3247, 33333, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3248, 33333, N'6c341a75-8c0d-4b12-94a2-a524b09f83bb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3249, 33333, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3250, 33333, N'91dd8e8d-0153-4bd8-83ea-700e45f5e6de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3251, 33333, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3252, 33333, N'44842db2-256f-4f1b-a668-aedb9e561a16', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3253, 33333, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3254, 33333, N'71570f9c-c72a-4608-bf35-bb9adf44ef36', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3255, 33333, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3256, 33333, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3257, 33333, N'e9c2ffb0-023c-4613-aa32-7bc6f2a81691', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3258, 33333, N'3ad4b5f8-71da-4c6d-9abe-7b5a16cd797a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3259, 33333, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3260, 33333, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3261, 33333, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3262, 33333, N'43c9c4f4-7a6b-44ce-b9f3-76c94df68ddc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3263, 33333, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3264, 33333, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3265, 33333, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3266, 33333, N'f0ebe1d6-1a11-41eb-8e26-a8641f180609', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3267, 33333, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3268, 33333, N'946982d0-e0c4-4c58-8959-c1731f793163', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3269, 33333, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3270, 33333, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3271, 33333, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3272, 33333, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3273, 33333, N'c99db12f-b24e-4957-be1d-dd0193a23a3a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3274, 33333, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3275, 33333, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3276, 33333, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3277, 33333, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3278, 33333, N'ca1e2ec0-efe1-4605-afe5-fda2721325b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3279, 33333, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3280, 33333, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3281, 33333, N'8bc76bc4-072a-4fa1-a74f-ed681854dc63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3282, 33333, N'621a5721-f5d9-42ee-a5bd-ef8cf86500b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3283, 33333, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3284, 33333, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3285, 33333, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3286, 33333, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3287, 33333, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3288, 33333, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3289, 33333, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3290, 33333, N'5d22f62a-7da4-457f-874d-d8f0d11cb13f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3291, 33333, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3292, 33333, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3293, 33333, N'1480a708-a100-4f72-9792-15232a0895c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3294, 33333, N'72595857-9760-4836-b5be-11c965e065f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3295, 33333, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3296, 33333, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3297, 33333, N'6e178c65-ab35-4fce-aa3f-0e148987dab9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3298, 33333, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3299, 33333, N'eb9a58eb-93a2-4e0e-a4bc-09d7d3908e02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3300, 33333, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3301, 33333, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3302, 33333, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3303, 33333, N'd617ff97-654e-4788-add5-c28e90abe680', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3304, 33333, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3305, 33333, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3306, 33333, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3307, 33333, N'a6192524-3d69-4a52-a92c-c564fc1baec5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3308, 33333, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3309, 33333, N'2755658f-cb5e-41e9-8298-c97721bdba77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3310, 33333, N'7cd7b0b7-e644-417e-87b9-cc0281e90027', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3311, 33333, N'8016ffaf-96be-4810-8191-cd3fdbeb5399', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3312, 33333, N'603beed9-c3c3-46e1-8560-19706553c33c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3313, 33333, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3314, 33333, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3315, 33333, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3316, 33333, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3317, 33333, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3318, 33333, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3319, 33333, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3320, 33333, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3321, 33333, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3322, 33333, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3323, 33333, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3324, 33333, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3325, 33333, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3326, 33333, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3327, 33333, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3328, 33333, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3329, 33333, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3330, 33333, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3331, 33333, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3332, 33333, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3333, 33333, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3334, 33333, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3335, 33333, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3336, 33333, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3337, 33333, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3338, 33333, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3339, 44444, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3340, 44444, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3341, 44444, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3342, 44444, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3343, 44444, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3344, 44444, N'7ab8d023-1fed-4230-98f7-e8ee50028f30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3345, 44444, N'4f788f04-93df-47f5-a308-cf110df2f2f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3346, 44444, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3347, 44444, N'4513ed01-2341-4581-b9b9-db7e81fe50c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3348, 44444, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3349, 44444, N'04351640-3e1d-4810-a0f5-3147f12031a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3350, 44444, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3351, 44444, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3352, 44444, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3353, 44444, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3354, 44444, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3355, 44444, N'f8309664-1867-43b7-adb8-7bd34ba687d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3356, 44444, N'9612b6d3-9770-45cc-b94c-7ee5f9250ac3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3357, 44444, N'26f81117-51f9-4638-aec4-801a6a296945', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3358, 44444, N'c571afdf-1f39-4715-9f4e-4f59043571b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3359, 44444, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3360, 44444, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3361, 44444, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3362, 77777, N'9ceecc2d-af3c-4a33-bbaf-5509d76be0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3363, 77777, N'0f288531-ba96-438f-b70d-5775de191ee2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3364, 77777, N'fb782972-bcd1-4f36-ba23-577b5e83363d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3365, 77777, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3366, 77777, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3367, 77777, N'3ff1b7e8-5c50-4e66-9d14-5474c49f36c6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3368, 77777, N'4bdedc60-9873-481d-aeab-53422bfe8d00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3369, 77777, N'c64cde5d-5fe9-4545-830d-4f967fdef70a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3370, 77777, N'658015c0-d4d6-4aa6-b199-4bfa36c25654', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3371, 77777, N'fb852cd7-b559-4a45-815a-46b71f80d49b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3372, 77777, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3373, 77777, N'a17f6c5f-71a4-4086-af06-43926cf30080', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3374, 77777, N'5f504070-4d93-4e8f-8cea-42bda43ef0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3375, 77777, N'9ebcf470-1da4-4448-b8f5-41d5442849ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3376, 77777, N'c7ce05b8-e71c-4d2a-9cfd-418baa8ad16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3377, 77777, N'7f0aac88-e922-4d37-923f-125c9cd8d5f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3378, 77777, N'376cbf30-280f-4ae0-af13-129d1cd02aca', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3379, 77777, N'4f79e454-0bc0-4f76-8fc5-163f7c0a380d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3380, 77777, N'6c104837-0a04-43d6-b200-177b98588522', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3381, 77777, N'ba0ec2b7-975f-4c09-bc72-194b78595bd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3382, 77777, N'4094eac9-0aad-4c8e-96f8-1b0f3cf807f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3383, 77777, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3384, 77777, N'4df02a12-b7ac-4535-bf22-1c87aae5f7fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3385, 77777, N'4653a3cf-5480-49a3-af52-1ede7d7a5432', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3386, 77777, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3387, 77777, N'c93f50bd-2a63-4387-bf62-21098294bcc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3388, 77777, N'97cd0360-554d-411e-98f4-21874b3396e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3389, 77777, N'cb29c5d6-6493-402c-891b-21d6cffda4a0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3390, 77777, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3391, 77777, N'5aae40c8-3c86-4f3c-8607-224f64ff8c12', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3392, 77777, N'6f97687f-b15d-4aa9-8276-25ccb33ccf53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3393, 77777, N'76ee4ab8-952e-4cff-8f67-2c7ae631a65f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3394, 77777, N'5e347146-ca72-41be-afdd-2d18472ff62f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3395, 77777, N'da8aecae-09e6-4f74-bfab-314673238ac1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3396, 77777, N'4b651a45-bf4c-48c8-97b7-333bb580b76e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3397, 77777, N'e0e88cac-a5ff-4dd7-9db4-3407f15efc15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3398, 77777, N'7d159002-e21e-4829-87de-346273d5eccb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3399, 77777, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3400, 77777, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3401, 77777, N'cbcf827c-99dd-4f4f-bf42-398ca5dcfbb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3402, 77777, N'2f5ac8f4-3bb1-4c3a-af66-39b81b3e8c4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3403, 77777, N'81d9a081-25e0-40d7-866c-3ac1684c2424', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3404, 77777, N'926ed709-a911-4314-92c6-3ced80431915', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3405, 77777, N'8abd5fc1-be98-4340-bc15-25b76115782f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3406, 77777, N'6df8b929-cc7e-47d4-9bc3-5c795140c6f9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3407, 77777, N'c80e6713-32ce-4c9d-ad80-704b460d0d55', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3408, 77777, N'6d3a46a1-2588-4816-be63-5d2518dc6701', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3409, 77777, N'7ee79c5f-71ac-40e4-90d2-913e2671666b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3410, 77777, N'953fcab0-ea43-41a8-a93c-8f5bd9a642e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3411, 77777, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3412, 77777, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3413, 77777, N'042a7bfc-5033-4490-aa0a-89790832f895', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3414, 77777, N'5fa827e8-96a8-4020-9153-8755f3c3de93', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3415, 77777, N'4248ba0b-646b-4525-a0a0-8713a10a608e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3416, 77777, N'7244e0a8-83d4-41d0-92ae-8315df470382', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3417, 77777, N'a761f852-3928-467b-9867-7dcf3f55d8a7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3418, 77777, N'a85d1a30-eda5-4f76-81a1-7c5e1fe77031', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3419, 77777, N'1c753625-4561-4abf-aef9-7a92b01e481e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3420, 77777, N'986a1121-10ba-40d0-8629-79768f5b4e89', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3421, 77777, N'418d053d-d730-4577-8e25-77584384703e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3422, 77777, N'183e2cc9-2522-4463-9366-775781dcb127', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3423, 77777, N'71b83b32-6e10-4bc8-978d-76b9ad44d135', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3424, 77777, N'1fa27253-d770-4f50-8cc8-75122eb1e68c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3425, 77777, N'2ed6803b-83f1-48e3-8b4c-73fd77f94c64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3426, 77777, N'cd30e343-60c3-4f7d-a566-72fe0718a90b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3427, 77777, N'224f64a0-3ebc-4977-b42c-72f7ddd5e0b6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3428, 77777, N'0233c973-c596-466d-8315-716d3f7d195c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3429, 77777, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3430, 77777, N'66b8d9f8-6043-4d79-b960-9265da657a3b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3431, 77777, N'a2f97b59-0b25-42d9-91f8-5cfc5a5ef1e6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3432, 77777, N'28e36f79-bac9-4340-a942-95dc9888c9d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3433, 77777, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3434, 77777, N'7bb9080b-247e-4a3d-b459-619677e19263', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3435, 77777, N'fc2da022-f055-48a0-9f91-643710950d43', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3436, 77777, N'bb3c8465-744e-4995-b231-6714a5d25df9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3437, 77777, N'97795e35-e1f6-4d05-afe3-6773afb2d254', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3438, 77777, N'a5993180-1136-4ee0-91d0-6cb0ed1113b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3439, 77777, N'b080e20e-de8b-4310-8cbc-0fffd2bcbfaf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3440, 77777, N'99cf3f7d-8adb-4b99-aa70-6dd99a714fad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3441, 77777, N'f683600c-bd77-495b-8baf-a76fd1df0215', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3442, 77777, N'da6eb397-3885-493a-8a79-a63a8257b246', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3443, 77777, N'86894159-c1f3-44ab-bddc-a578289077a5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3444, 77777, N'e7b3084b-711a-43e3-8ab6-a37af089281e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3445, 77777, N'0356eb50-3f15-4843-88ea-a130922a1ced', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3446, 77777, N'ee2f083b-d33e-4c47-8f9d-9edc32732c28', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3447, 77777, N'93b2b36c-fac6-48af-822c-9e1b69c0c889', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3448, 77777, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3449, 77777, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3450, 77777, N'1fc23099-0aff-4d52-be49-9cbcba9405ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3451, 77777, N'e5a6ccba-20d6-47db-b131-9c564f67a361', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3452, 77777, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3453, 77777, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3454, 77777, N'5fb337a9-70ec-46e2-a53e-9824ae05fd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3455, 77777, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3456, 77777, N'0c44009b-8006-4cc4-8d36-0eb29bcc4bc5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3457, 77777, N'39887b12-6eee-4997-b509-b0bd643a727e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3458, 77777, N'ad2e8f8d-5a50-4595-b042-09f80b3db8c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3459, 77777, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3460, 77777, N'e199ce89-ee01-4fd2-9958-dbb46ed84b1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3461, 77777, N'e0598603-65e3-413a-b375-df073ea07f6d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3462, 77777, N'e058ee51-e99c-4d5b-8060-df2944d1b9d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3463, 77777, N'3bcd0ad7-5a07-41a4-9061-e3136cf3a97b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3464, 77777, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3465, 77777, N'e38245ee-78ad-485c-8944-e3ea979ca9ce', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3466, 77777, N'49c9ef74-ab94-4204-8b9a-e935540468cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3467, 77777, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3468, 77777, N'b81c3f17-16f9-4cf0-8b61-eb0d387e65d8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3469, 77777, N'2589ba88-616e-4aff-b14f-ed468eed0549', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3470, 77777, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3471, 77777, N'8cb4ccb4-e08b-4d4b-ba28-ee6845ccfeab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3472, 77777, N'e23511de-8c7d-4c4b-8723-f18c9e3b9240', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3473, 77777, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3474, 77777, N'6088d17b-f162-42a5-9818-f41ee5e0d16a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3475, 77777, N'f41f13d6-190d-4f8b-9432-f6423811314a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3476, 77777, N'ecf86452-0e62-445c-b370-0e7ca708212b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3477, 77777, N'776d3e4e-c68b-43c3-a5a3-f91385bd6296', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3478, 77777, N'722fdfcc-02ee-4680-b684-fcc7230714cc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3479, 77777, N'19fb2c66-f026-43d1-b9e9-ffa44498e3a4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3480, 77777, N'f5c5f7a1-e820-4a45-89dd-fdfd10b1361d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3481, 77777, N'4e1a462a-70fd-4454-96f8-fe543bce337a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3482, 77777, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3483, 77777, N'5f376240-3764-4733-a269-aad8b2f2b886', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3484, 77777, N'2024b4f0-2771-4431-a8af-d7264b28d962', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3485, 77777, N'1d96dfb4-c37d-4662-9527-d71b4834dd98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3486, 77777, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3487, 77777, N'72ab7a79-351b-4893-8b79-d4d03fa39b4b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3488, 77777, N'fbc5c4d8-c6df-499f-8ff4-09363d57b9fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3489, 77777, N'41328f04-b725-4435-837b-082e169aea31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3490, 77777, N'3a77dfc3-7392-411c-aa42-078753a10e7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3491, 77777, N'd8f89701-7006-48e9-b2ec-0679551a0418', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3492, 77777, N'51c504b7-3fd2-4111-9652-05b295f0732f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3493, 77777, N'04564a71-cc75-4d65-934f-03d6598429df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3494, 77777, N'af5d4af2-8810-4ba1-a628-003796357bfb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3495, 77777, N'249ba7d6-26bc-43df-b75d-b568252cc2c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3496, 77777, N'd604fb47-2f09-4a36-8ccc-b697fcbf3205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3497, 77777, N'ed3a4a01-b363-4d81-9dd6-b736a3431293', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3498, 77777, N'0f4e5cdb-c8f2-4c2f-a040-b84cf359503d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3499, 77777, N'd779a487-38cd-4942-b8ea-bb16dc14c07e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3500, 77777, N'd69f1386-5aec-4eb0-85b8-bf8b0c0bbcd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3501, 77777, N'5ecd5632-52e2-4387-b1e7-c1e21a5bb7ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3502, 77777, N'a810e3ae-f1d6-4cf8-92ef-c47bfb0ae5f3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3503, 77777, N'bf1c91c1-e740-4bf3-a0c3-c5017f67890c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3504, 77777, N'2719c551-cb62-45f0-8091-c595fccf11aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3505, 77777, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3506, 77777, N'484b7de1-561e-4a44-91dc-c8ea4c33d0f1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3507, 77777, N'ce9f3b44-8de7-4388-bf64-cc8839d6eec1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3508, 77777, N'd14c1f58-7b5b-4f0c-853a-d03db92d92b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3509, 77777, N'1370af42-416b-4af5-8416-d274643cc31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3510, 77777, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3511, 77777, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3512, 77777, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3513, 77777, N'7541f25b-34db-4ad5-a8ae-09d1dd558706', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3514, 77777, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3515, 88888, N'104d522c-cab9-4916-be40-62e7c00de59c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3516, 88888, N'4d7fa507-2170-425e-96f0-f42822ff6311', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3517, 88888, N'4c5b37fd-34d7-4148-9c84-1ab08be35e14', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3518, 88888, N'49bc61be-8c43-4854-9d06-b61ae3118a92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3519, 88888, N'57302d72-6ffb-4f7c-a191-11e00c17b4ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3520, 88888, N'3bdfce52-fe6a-4886-a070-ce2b9445927f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3521, 88888, N'2394c5ad-3ca0-442d-8a0e-84e9e88fa9e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3522, 88888, N'fce10d8f-864c-4f58-b616-17a13b848f70', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3523, 88888, N'd87ce1b0-b82f-4927-8ef4-cee2b7d54d07', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3524, 88888, N'd32b919b-6b19-4548-af32-5854f6d795fe', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3525, 88888, N'413143f0-12c1-4787-85e3-683d02a3fbd0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3526, 88888, N'16353f67-23c3-4cf9-9a88-16eaa18f10d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3527, 88888, N'12ff2938-c6a4-4c1f-8e91-6cafb14237c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3528, 88888, N'f4ae521c-e52a-4e36-a13d-7d238dab1469', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3529, 88888, N'7ab79bd1-ca2e-4a57-b42c-2a93f1a0bb53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3530, 88888, N'195f5149-f23f-468b-8cf6-c85390bb28f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3531, 88888, N'7e744dff-c580-4d1e-bbb4-36d6b3d8481f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3532, 88888, N'8bd4017e-1b0e-432c-97cb-8b13bf6274fd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3533, 88888, N'128f7feb-b9e3-468d-b66d-12a555b4f9c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3534, 88888, N'94329f27-c3bd-45ab-8e06-60e4a0199878', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3535, 88888, N'92ce95e7-533d-4dc3-84c2-7e8725545ca1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3536, 100004, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3537, 100004, N'693dfee7-b819-450c-941c-2d2951c1ae6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3551, 100008, N'8dba27fc-b2b2-44f4-b435-9e01567c7930', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3552, 100008, N'4fc9685e-45df-4fc9-8df8-1cf6411fdc4e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3553, 100008, N'fdc3b9bb-eca3-4d7b-b052-7141cdde0ae3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3554, 100008, N'86bdfbf1-da6b-451d-8b42-1753a1ffd9b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3555, 100008, N'cee0b8da-da01-46a6-a43d-cb8d4f5ed2d4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3556, 100008, N'79eae367-9044-4aec-99b5-0e7f3b7fb274', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3557, 100008, N'c0f38a2c-3b25-4e71-a14b-da187ddce3cb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3558, 100005, N'e21a8021-5299-4845-b534-fd1f3c46ab69', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3559, 11111, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3560, 11111, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3561, 11111, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3562, 11111, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3563, 11111, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3564, 11111, N'1d587003-8abd-4e4c-a096-5fa386feb25e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3565, 100006, N'009e783c-f124-4501-b596-1b2789d14e4e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3566, 100006, N'c33f0629-2e33-47f0-9516-4770622c474e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3567, 100006, N'ad7fa573-0990-40ed-8995-50405cb9b110', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3568, 100006, N'17851920-0697-4d72-a2ef-8bbef73d733e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3569, 100006, N'85305898-2b4a-4d27-a392-d48415f0184a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3570, 100006, N'35b9c1dd-a489-46b2-82b1-dbbe1a60ba46', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3571, 100006, N'4ce18dc6-6f90-4f2c-980f-434c58a376b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3572, 100006, N'52755d07-ac8b-47c0-8c6f-78419ece74c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3573, 100006, N'91f6af0a-3880-47e9-a91c-99a2e6b9aa74', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3574, 100006, N'cfe2d3c0-a510-463b-8d36-af09931373bf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3575, 100006, N'9176e90e-ea64-4a51-8868-c845a1b8cacb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3576, 100006, N'29b225b7-6a86-4d17-aa32-f158cd0c43d5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3577, 101036, N'79840ee6-ecad-4226-ae82-0c1d8fdcd43b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3578, 101036, N'fe8641a3-25ac-467c-9e45-7bb77b77e51f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3579, 101036, N'895be2fc-5e7a-4870-bd00-4631e5707977', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3580, 101036, N'3c41d05b-69ec-43f2-897e-8057896e0b62', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3581, 101036, N'18c4ca5e-a036-4f53-a95f-21ab6d36632e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3582, 101036, N'18c4ca5e-a036-4f53-a95f-21ab6d36632e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3583, 101036, N'd0d08b53-a029-4683-acbc-1e2ab75ea3ad', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3584, 100011, N'4095f424-c8be-4707-9e22-5cdcb62a3eba', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3585, 100011, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3586, 100011, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3587, 100011, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3588, 100011, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3589, 100011, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3590, 100011, N'18fbb831-3560-4576-a594-6f16ddd1df05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3591, 100011, N'ccd9f13b-0921-4758-9e91-7a2db2d9e1fb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3592, 100011, N'3e152b0f-dc4c-4416-8352-8569e8343fe9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3593, 100012, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3594, 100012, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3595, 100012, N'4d5682dc-047a-4c47-8de1-b57cdd620cb4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3596, 100012, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3597, 100012, N'edb77114-1960-4772-88a3-e32307dcf0a9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3598, 100013, N'a3ea8642-aa44-45f4-9b53-060b114819e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3599, 100013, N'b3779102-6613-4722-b1dc-1dee85ba2064', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3600, 100013, N'd10a78e3-74fd-42c0-84b5-540cca3bbb1f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3601, 100013, N'2b24a538-6ada-4cf2-8c38-69a13782bef4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3602, 100013, N'248be8c8-6ac0-4f40-a72d-ee946afba9af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3603, 100014, N'c0916b52-e9a6-40a6-a00a-02c8aa4522c8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3604, 100014, N'933e29fd-f6fb-4317-b0c7-5cbb7655a06e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3605, 100014, N'dbf5545e-ab61-438b-8a50-606995d1f30b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3606, 100014, N'3e9cb15d-18a0-4f6b-81b8-8350b97f2d92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3607, 100014, N'26106a36-d4fa-4b25-8437-9355039afbd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3608, 100014, N'ac90f3e3-6a01-4868-be25-bffe6d93ac8e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3609, 100014, N'63a7471e-ccea-4422-bc2b-c1acbf9066b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3610, 100014, N'30fd5982-45d0-485c-a969-c672f21b7358', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3611, 100014, N'6ff78f47-541e-4bab-a71c-f0350adb3543', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3612, 100015, N'07d35985-0229-40c3-aaed-0fce364b33c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3613, 100015, N'baca0b66-1cfd-469f-8eed-5442857d76b5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3614, 100015, N'34a0f7d3-7f88-4de8-8c29-a1827670a940', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3615, 100015, N'8afd823d-0311-48c0-b4e0-a2c90e1b48f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3616, 100015, N'78cd9a43-83e5-4e17-971f-c7fb05de9bcf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3617, 100015, N'621fe63b-cf18-454b-8404-e8bec47154b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3618, 100016, N'06048d73-4dd8-42e1-b095-806c636ff9f0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3619, 100016, N'7bf06c1a-3e9b-4aa8-9b2e-8a4f81cd367c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3620, 100016, N'ba03a869-330e-4ef3-b2b0-a8fcf466bb2e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3621, 100016, N'bd4359bf-c1d2-4e70-87b8-e4c77839b2ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3622, 100017, N'9e222535-8111-4ded-b5c0-2de91ae52e92', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3623, 100017, N'66754c61-6ecd-44cf-9ae4-543635e0d460', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3624, 100017, N'4f87e0bd-8e17-4956-a3bf-5bbe6f75221c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3625, 100017, N'45eccc6e-6a8e-4a00-aee1-b046e94f7b68', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3626, 100017, N'f9e4c5cf-70e0-4881-b8e0-fc4de96afd82', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3627, 100018, N'a8158cb8-7a34-4267-9e33-1b138b6fea2f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3628, 100018, N'fc8a73be-4987-4cd7-b980-39e5b658f2aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3629, 100018, N'8cae7fb4-1f9a-4add-ab1e-a466c2cbd702', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3630, 100018, N'1fbc4b46-46d4-4e3c-afd6-e007dcef5205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3631, 100018, N'1db4fb60-19a8-410d-9b19-f8448d480dc7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3636, 100022, N'd676cd58-7d69-4eec-b6f9-0cb34391d9f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3637, 100022, N'3798b3ec-5f8c-4aab-9109-1d92a0b557c1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3638, 100022, N'0d84d845-7b4d-4c1f-bd29-29f870cbcf50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3639, 100022, N'6755075e-2096-45d5-9b09-48c50d51660f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3640, 100022, N'c6ccb699-182c-4ec6-8f40-4a61032b78a8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3641, 100022, N'b00708a6-8e38-4cbd-9bd1-5d6cb382cf35', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3642, 100022, N'2ed16d00-54cf-40d9-a6ae-8ee4d26f9a32', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3643, 100022, N'eca3ffb8-c1fb-4212-a543-a04e9e396784', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3644, 100022, N'9454ba64-87ca-4ffd-b497-bb8e5eea8639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3645, 100022, N'e59dbc98-5393-4fc4-8996-c05fe4852558', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3646, 100022, N'dcf849b9-583f-4a23-b2c0-d3298ea74865', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3647, 100022, N'2f7a31cf-6236-4eb4-b1d1-ee065980741a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3648, 100021, N'009e783c-f124-4501-b596-1b2789d14e4e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3649, 100021, N'c33f0629-2e33-47f0-9516-4770622c474e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3650, 100021, N'ad7fa573-0990-40ed-8995-50405cb9b110', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3651, 100021, N'17851920-0697-4d72-a2ef-8bbef73d733e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3652, 100021, N'85305898-2b4a-4d27-a392-d48415f0184a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3653, 100021, N'35b9c1dd-a489-46b2-82b1-dbbe1a60ba46', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3654, 100020, N'29b225b7-6a86-4d17-aa32-f158cd0c43d5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3655, 100020, N'9176e90e-ea64-4a51-8868-c845a1b8cacb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3656, 100020, N'4ce18dc6-6f90-4f2c-980f-434c58a376b7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3657, 100020, N'52755d07-ac8b-47c0-8c6f-78419ece74c9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3658, 100020, N'91f6af0a-3880-47e9-a91c-99a2e6b9aa74', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3659, 100020, N'cfe2d3c0-a510-463b-8d36-af09931373bf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3660, 100023, N'746ae716-0bd2-46e7-b7ef-35f1f5f7fb15', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3661, 100023, N'dd748a92-303d-45fa-82c5-cb6697329f29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3662, 100023, N'30ed6b09-268f-4e07-9bdf-d003d7d32502', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3663, 100023, N'46e960cd-92c8-4657-b8f1-e066ed8005ff', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3664, 100027, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3665, 100027, N'97dc1c97-a947-4171-95be-59fa23ac90dc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3666, 100027, N'd473bcce-1332-47fb-95a0-1bf7b479b5ae', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3667, 100027, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3668, 100027, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3669, 100027, N'cf7c8c64-b8cf-41c0-8bb3-f65ac73c0147', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3670, 100027, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3671, 100027, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3672, 100027, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3673, 100027, N'16cc4069-dc25-49d7-b272-dcfc28549301', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3674, 100026, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3675, 100026, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3676, 100026, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3677, 100026, N'a359eaa9-7f55-4f64-aaa7-bcb07115cfc3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3678, 100026, N'0cca5b44-467a-4807-a0e0-d583c693d776', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3679, 100026, N'1428c6ec-25d9-477d-ab4e-efae61b2377d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3680, 100026, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3681, 100026, N'017a0e7d-7829-4326-bdb7-e285e7aae9bc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3682, 100026, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3683, 100026, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3684, 100025, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3685, 100025, N'5d007fd4-976f-4f44-b580-50a2afe0815f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3686, 100025, N'a35adf1d-f4f6-494f-975a-0492fffa70db', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3687, 100025, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3688, 100025, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3689, 100025, N'c6e0724d-fc34-4235-b0fd-f5098312de8d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3690, 100025, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3691, 100025, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3692, 100025, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3693, 100025, N'86ef34f3-b62f-4d0a-a673-bfecd5a8730e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3694, 100024, N'8e3189a1-c37a-4004-86bd-6c8189a9b764', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3695, 100024, N'5281d288-b1b4-4e3e-9a00-5d5ab4437019', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3696, 100024, N'5c6b6ad9-1b90-4d2b-b36e-2ba2cf5075fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3697, 100024, N'45071ef7-21bd-483b-9b88-9711dcab397f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3698, 100024, N'baaaea28-f16e-43d5-a4b5-a816cbcb1262', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3699, 100024, N'0cee8cd0-1ebf-48fc-a517-ea387ea80b9f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3700, 100024, N'9e2459c1-6e9b-4ff2-ab99-7d8c83dbfae8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3701, 100024, N'5f410902-9c3b-47db-b648-e154b97b09d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3702, 100024, N'44b001e5-5208-4cd9-ab76-7d7b19cef3d0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3703, 100024, N'2e40ab73-0553-47b0-9eb5-d9eb534e05b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3704, 100017, N'4724ac7e-70b1-458f-acf9-a8629521faa3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3705, 100023, N'888c5233-b854-478e-b3e6-860eb288a09c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3706, 100024, N'2755658f-cb5e-41e9-8298-c97721bdba77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3707, 100025, N'603beed9-c3c3-46e1-8560-19706553c33c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3708, 100026, N'cd9d2c5f-6e4a-4f72-8b9b-592ce681bb0d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3709, 100027, N'cc05f689-5a26-4084-957f-468ffa646d39', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3710, 100028, N'84306d93-5bf1-4d7c-a6ec-081f9e38b4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3711, 100028, N'88888a3e-9ecb-43d6-9fce-099336b2a534', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3712, 100028, N'33dc2049-6b77-4753-b6aa-6c3a9ba81a30', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3713, 100028, N'860db2d3-2007-4fe3-a622-96efaea97956', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3714, 100028, N'b7e30a6e-02bb-4b23-8762-a0121459bf94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3715, 100028, N'c72d3e91-40d8-4e04-b9cb-b0e1e733d11f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3716, 100028, N'53d212dd-b678-4888-9208-b66fa0042ff2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3717, 100028, N'a97affbe-b4da-40f6-8055-f493cef4d9e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3718, 100029, N'04ff068e-70bf-43eb-ab00-1c8a7fcfd98e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3719, 100029, N'86de038f-e73a-4cf8-9d0c-3c488130396e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3720, 100029, N'85e9bab0-c315-45b8-8922-51faeb4a7a9c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3721, 100029, N'7ae52d61-2e8f-40c1-9b16-55a1b016a286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3722, 100029, N'df22e2e1-73df-459b-826b-630bf62e8394', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3723, 100029, N'b8afa156-3522-420c-9118-c7fce2208fcb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3724, 100029, N'02268ec7-c879-47b8-b174-de3c359eff7a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3725, 100029, N'3761b8fd-6b23-4d86-81de-eb6de7891a5a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3726, 100030, N'b8d98f19-8e6b-4ad2-be55-09496026a374', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3727, 100030, N'2373a969-c468-4c48-b26b-371641253486', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3728, 100030, N'1d587003-8abd-4e4c-a096-5fa386feb25e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3729, 100030, N'ebe5d62c-129d-42a3-8097-809cd113944f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3730, 100030, N'2a12cf61-2fda-48d3-a5a2-850bf0dee8a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3731, 100030, N'cc9e11cb-ce75-4b13-9453-87de0759b42a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3732, 100031, N'3fdfff1b-d420-4ef3-82d5-114965a4bbb3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3733, 100031, N'e836ff6b-6648-40f2-a2dc-1c160027ef4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3734, 100031, N'71c72458-d0d0-473f-90ee-3bbdce5bedd9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3735, 100031, N'a4b6168d-3589-4dfa-8a92-523ac1d03d99', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3736, 100031, N'0c2413e5-e633-4d8f-94f8-56574ed1cc05', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3737, 100031, N'896b337d-445b-453a-b6ce-5a64bf11b65d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3738, 100031, N'30d722ce-e903-4fbb-a047-b3e6f50a5d60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3739, 100031, N'4ffcb62c-e083-4e8d-84f1-c5cb0ba0e182', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3740, 100032, N'7ef88a1e-aa1d-4253-aa3a-2a6d83dc4db9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3741, 100032, N'1dc84c88-352f-488c-a927-58032f88a3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3742, 100032, N'aeb6253e-2532-4873-b8df-9ac559908658', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3743, 100032, N'646a1da2-f25a-4782-8430-a7c7e8762da3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3744, 100032, N'd04bdd1c-7ba9-4552-a50c-a8c30ec313f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3745, 100032, N'f8466ff9-612f-4fe3-8a38-f460ca9ad05f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3746, 100027, N'14435987-a010-4981-aa0f-80d1e4498d4f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3747, 100027, N'c2f64a4d-0314-4f9c-bc62-871e1cb9a15e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3748, 100027, N'a30379d3-1c9c-4716-a4c4-a7da7c2d59d2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3749, 100024, N'520af6c2-5f31-488a-8970-0a390b7c9c34', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3750, 100024, N'c8ae1043-e193-410f-a0ce-51a673b812e0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3751, 100024, N'21c8a894-f7d6-4747-bbc4-c2b21e733568', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3752, 100025, N'723ef204-7dd0-4a0d-9d5c-0fe82ecaa8e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3753, 100025, N'51897e01-9b8a-473a-b20b-4d1b5f572d87', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3754, 100025, N'b7272bcb-3b40-455b-93aa-5ebfa077cf5c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3755, 100026, N'e7481cae-21d5-4239-ba7a-60ead03573c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3756, 100026, N'80f4e203-94e3-400b-a7e7-6c08a7e132e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3757, 100026, N'e71cf7c7-ac92-4f60-88a4-c2ea3cd6a48a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3758, 100033, N'89e4f583-900b-43ec-ab63-34e838f35a81', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3759, 100033, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3760, 100033, N'7efd7fbb-8ab1-4046-8267-753db514c23b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3761, 100033, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3762, 100033, N'090a15ef-8766-435c-89a4-78aa54fda44d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3763, 100033, N'441c0141-35ff-4233-9945-e797233f4fa4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3764, 100034, N'd84dd72d-7b49-42a8-8c05-f7ac1b89e292', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3765, 100034, N'f67dc3da-3462-4d05-89a6-26fa0ea757ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3766, 100034, N'26fcb95c-1250-489d-ac10-ac96a29d9696', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3767, 100034, N'1b7b3a4e-0bc7-46a2-8b5d-bec399467208', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3768, 100034, N'b24a6a98-4873-4078-9980-893bc95f12ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3769, 100034, N'07c9865f-1fc0-4d43-81cc-2c7e38654e51', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3770, 100011, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3771, 100012, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3772, 100013, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3773, 100014, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3774, 100015, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3775, 100016, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3776, 100017, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3777, 100018, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3779, 100020, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3780, 100021, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3781, 100022, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3782, 100023, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3783, 100024, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3784, 100025, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3785, 100026, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3786, 100027, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3787, 100028, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3788, 100029, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3789, 100030, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3790, 100031, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3791, 100032, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3792, 100034, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3793, 100025, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3794, 100025, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3795, 100025, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3796, 100025, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3797, 100025, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3798, 100025, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3799, 100025, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3800, 100025, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3801, 100025, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3802, 100025, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3803, 100025, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3804, 100025, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3805, 100025, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3806, 100025, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3807, 100025, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3808, 100025, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3809, 100025, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3810, 100025, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3811, 100025, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3812, 100025, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3813, 100025, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3814, 100025, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3815, 100025, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3816, 100025, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3817, 100025, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3818, 100025, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3819, 100025, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3820, 100025, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3821, 100029, N'49dcd5da-3149-42b7-9861-cab2aa575b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3822, 100029, N'681c3f06-93ec-4d82-928a-21425d6dbb91', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3823, 100029, N'87ddbe2e-d742-4dd7-816c-d4d1c9287ccc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3824, 100029, N'f1e36cc2-8a6b-4b08-80ed-465ebeca3de3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3825, 100029, N'b6875160-0302-4d15-9bd9-3431e21aeb24', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3826, 100029, N'93481abc-8bc8-4b26-b02b-d2eb935903d6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3827, 100029, N'45b5e4ac-25c1-42a7-963d-2491b4d13ece', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3828, 100029, N'b22348a4-a36e-4d01-b2e7-578697d4a8e9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3829, 100029, N'0b2784fb-2158-461f-a83c-08b221cea5c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3830, 100029, N'42da2ebe-fb35-439a-92c5-f404c3e0a12d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3831, 100029, N'9ff9f2d1-8af0-4fac-a111-9acf84207453', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3832, 100029, N'd5556e17-27ad-44a0-b80d-2fd734a4c2f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3833, 100029, N'b6d86e76-3ef6-48f6-873b-4cdf3875bf29', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3834, 100029, N'65e27bce-38e0-4497-b95a-39024db06652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3835, 100029, N'1c969e3f-5fb9-42c1-8a39-8c84122aded1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3836, 100029, N'b9875a52-3204-4d50-8c95-08b7018586ea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3837, 100029, N'f259ce28-7dad-46f1-adf2-24e6436d79fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3838, 100029, N'207733d4-37a4-4b04-a973-27fcde23cc61', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3839, 100029, N'eb8e51f1-2239-43c2-b606-3547a0f96ee7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3840, 100029, N'3b3af5f0-6e91-4cde-a99f-427a96b8db60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3841, 100029, N'4d5cb5dc-09ea-494d-bc19-6625f98e98c7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3842, 100029, N'8b5e351f-1067-4eeb-ac41-9151079de165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3843, 100029, N'1a33a525-bc0d-4974-a271-9779ba13b699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3844, 100029, N'44142e0e-7505-4961-9402-9a89fbb12ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3845, 100029, N'c6e5f364-f6ea-4e98-ad9c-d508cb27bc02', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3846, 100029, N'6ff63d84-12c2-4d82-9ce1-e7e09ec5b341', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3847, 100029, N'18facde4-8d07-47db-b7be-ec800b01751b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3848, 100029, N'6a74f264-0c50-4201-8772-f71229bbf01c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3849, 100011, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3850, 100012, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3851, 100013, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3852, 100014, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3853, 100015, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3854, 100016, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3855, 100017, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3856, 100018, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3858, 100020, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3859, 100021, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3860, 100022, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3861, 100023, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3862, 100024, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3863, 100025, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3864, 100026, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3865, 100027, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3866, 100028, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3867, 100029, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3868, 100030, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3869, 100031, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3870, 100032, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3871, 100034, N'4046572a-ab91-4548-bcfc-7747eb7df41c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3872, 100036, N'60510b13-e60f-4802-a0df-2f96e3ddd31b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3873, 100037, N'ff7e3955-bea4-4ff8-8d54-b50c358a6b64', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3874, 100038, N'03bd4fe6-a503-47b4-b67f-9fb1efc1b11d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3875, 100039, N'2f70b149-321e-48cd-8c01-daa0125bc7e5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3876, 100041, N'd6deb272-9e33-430e-bebd-77b8d131d624', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3877, 100042, N'71cd9d72-3dfb-4577-a350-99a2cf36b146', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3878, 100043, N'1de55d52-1dcd-44ec-9938-54edb726274f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3879, 100044, N'5b45e026-a699-4bd6-8b72-7e6eb93a7976', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3880, 100045, N'9872c5e7-c954-465d-ae44-5b5f25acbe6c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3881, 100046, N'885a848d-b8d2-4811-9013-373a5e539183', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3882, 100047, N'c48591bf-ac03-4d47-9a86-dc0824a1e7aa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3883, 100048, N'c2c8274f-d78a-49ce-9fc4-a654fd6fb200', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3884, 100049, N'78a46c87-7a2d-4afc-98a8-c73ed2510f31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3885, 100051, N'7d3e9af7-c97e-41f3-bbe0-1f7f763460cd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3886, 100052, N'c8d2a578-8893-4567-adb0-5a7aa636e6ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3887, 100053, N'afb5a8fb-744f-4525-b799-707c3d070763', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3888, 100054, N'147118cf-5dcf-4aa8-8577-1f28a610ca4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3889, 100055, N'127a7f62-1605-44be-b6a0-113d76e8d172', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3890, 100056, N'c822c8ea-b523-4f7e-b501-5835bb798a7e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3891, 100057, N'8c6a2182-38d3-4782-b68c-41ffa5328b95', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3892, 100058, N'9df9abd1-7ec7-4809-a1ee-f2f817aab699', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3893, 100059, N'be512744-b639-4f8a-ab84-e7f568ff5289', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3894, 100060, N'a8957afa-099e-477c-88aa-2c36d681d3b1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3895, 100060, N'1bd6407a-fda2-4f93-8992-528d4157473d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3896, 100060, N'bdb8a6cc-a897-424d-bb75-6b0fc5081eef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3897, 100060, N'cd974dc6-f465-4948-98dc-8c3a42bb811d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3898, 100060, N'83072c68-ad3e-48eb-a09b-2be13af8249c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3899, 100060, N'442be8ba-8e8c-4866-91d3-4e8e4120d539', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3900, 100060, N'3eab3215-4b8b-4e68-ba02-d0e7d5b702da', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3901, 100016, N'db71cf78-8417-4fc0-aabf-4b955796d9a2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3902, 100034, N'd84dd72d-7b49-42a8-8c05-f7ac1b89e292', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3903, 11111, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3904, 33333, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3905, 100011, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3906, 100017, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3907, 100020, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3908, 100021, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3909, 100023, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3910, 100024, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3911, 100025, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3912, 100026, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3913, 100027, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3914, 100028, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3915, 100029, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3916, 100030, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3917, 100031, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3918, 100032, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3919, 101038, N'0911caa7-8243-422b-b0d2-6e719a304f5e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3920, 101039, N'385e6ac2-f2b0-47aa-a2ba-edea5d6093c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3921, 100062, N'04c4ae31-23ca-4cf1-8057-c596d605ff56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3922, 101040, N'ca384b0c-2acc-4b8c-ae27-0546a6c13329', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3923, 70002, N'fd671f2f-5b90-4de3-9a07-157b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3924, 70003, N'fd671f2f-5b90-4de3-9a07-167b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3925, 70004, N'fd671f2f-5b90-4de3-9a07-177b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3926, 70005, N'fd671f2f-5b90-4de3-9a07-187b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3927, 70006, N'fd671f2f-5b90-4de3-9a07-197b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3928, 70007, N'fd671f2f-5b90-4de3-9a07-207b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3929, 101041, N'40e67972-49d3-42e1-88fd-c6a29897b5fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3930, 101041, N'158b2316-1cab-48fd-b92a-dac77181ee4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3931, 101041, N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3932, 101041, N'a934907b-f09c-45ab-872b-754abe5d3059', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3933, 101041, N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3934, 101041, N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3935, 101041, N'6af76bf9-7130-4d42-9790-b69a1c22a145', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3936, 101041, N'40e67972-49d3-42e1-88fd-c6a29897b5fc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3937, 101041, N'158b2316-1cab-48fd-b92a-dac77181ee4a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3938, 101041, N'3c3d8f37-e0f0-4131-a2d8-6c8d62fa9930', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3939, 101041, N'a934907b-f09c-45ab-872b-754abe5d3059', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3940, 101041, N'fa334f3d-e0d6-472b-aaac-7d6a5276eda4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3941, 101041, N'4108b9d2-28a8-4bd8-afe2-140caab5d23c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3942, 101041, N'6af76bf9-7130-4d42-9790-b69a1c22a145', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3943, 101042, N'fd671f2f-5b90-4de3-9a07-247b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3944, 101043, N'fd671f2f-5b90-4de3-9a07-607b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3945, 101044, N'fd671f2f-5b90-4de3-9a07-617b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (3946, 100166, N'58784307-6eaa-4132-bb4f-1439cc7ba256', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4902, 101045, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4903, 101045, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4904, 101045, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4905, 101045, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4906, 101045, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4915, 101013, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4916, 101013, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4917, 101013, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4918, 101013, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4919, 101013, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4926, 101011, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4927, 101011, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4928, 101011, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4929, 101011, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4930, 101011, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4931, 101009, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4932, 101009, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4933, 101009, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4934, 101008, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4935, 101008, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4936, 101008, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4937, 101008, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4938, 101008, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4939, 100010, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4940, 100010, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4941, 100010, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4942, 100010, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4943, 100010, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4944, 100010, N'0156ec76-73ef-44c2-aa58-fc8e380e9683', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4945, 100007, N'81dfe010-14a0-48a7-aa0d-48023d967286', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4946, 100007, N'c66c33e2-d3b8-44f7-acfb-4d56498f3627', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4947, 100007, N'46c3a05b-eb2d-4b5d-8602-797059bc2e37', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4948, 100007, N'1b4fe8c2-e2cb-49b3-a5ad-cfc9ec2e4a58', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4949, 100007, N'fb5cf58f-09b4-4e82-bfe7-02f62b4f0dd2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4950, 101017, N'f306de2f-2d2b-4234-8bea-01e0d3ec977d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4951, 101017, N'4489d5f4-17dd-4ec8-8f29-152cb9af1629', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4952, 101017, N'a929572d-d410-4af3-bef6-54cabf950006', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4953, 101017, N'a41ac9d1-7da0-42da-b965-67b848291b00', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4954, 101017, N'fec2953f-8d6a-486e-be75-da22ce474769', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4955, 100003, N'fd418060-07ec-4e8a-8c50-705c2c224506', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4956, 100003, N'3eb1157c-852d-43ea-a65f-7073e3897613', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4957, 100003, N'b19af782-0c9f-40b1-8228-6f6a603a0ca7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4958, 100003, N'4b1d6f27-d878-4d1c-9b9e-6d7291251198', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4959, 100003, N'4915c87a-4c0a-4635-beb4-6626d46415c2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4960, 100003, N'422f1608-e641-4ec1-9163-636bb3c6962b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4961, 100003, N'af2dfe18-6a90-406b-891d-6308772f1223', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4962, 100003, N'f23a0afe-4f7e-49b7-936f-5c64c2f93f72', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4963, 100003, N'77d4dce7-5208-4995-9ac2-5bfb49f3bc94', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4964, 100003, N'5084a806-f1f9-4753-a856-5a82c1f8a54a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4965, 100003, N'a1aab54d-bf1b-488d-b1f0-2435306d77fa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4966, 100003, N'e0488c12-4dee-4420-98b1-25d91aa840f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4967, 100003, N'7a7cebf1-3ed2-4c49-8e2a-2647ac09572e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4968, 100003, N'176d82de-4723-4ed2-bc44-2775f36965c3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4969, 100003, N'ecdf590e-a91e-4fc3-9208-2dfd3e0b911f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4970, 100003, N'c1df5586-1d4d-477a-85bf-32a344c726ee', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4971, 100003, N'9a9c9328-c381-48e9-9670-347caeea1761', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4972, 100003, N'c08f29c7-a3ae-4dd8-ada3-40220f6a9582', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4973, 100003, N'a1ca4007-d64e-4765-af61-42e753a61222', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4974, 100003, N'8d6a9277-682f-4f30-ba42-44a4692fd69a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4975, 100003, N'9a548ee3-8010-4e74-bbb8-45a47b3ecbdd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4976, 100003, N'68fec29f-1c31-4860-8e21-47e345398528', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4977, 100003, N'226744c0-2184-4c6c-aed7-4ef91d60aff6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4978, 100003, N'ef03d792-249e-4b31-b131-58f247fd399a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4979, 100003, N'b5e41cce-5aca-4c1f-99c8-5a46f38bc83e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4980, 100003, N'9d395974-bec0-47e7-b32f-743afcc422de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4981, 100003, N'5d854334-c1b7-48c8-8811-7a37ca16dc7b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4982, 100003, N'e83a0045-89c6-459f-8d99-89c25077f4ef', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4983, 100003, N'99916b67-3c87-4342-8eb1-8640d0d9efd1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4984, 100003, N'ebe72adb-8f92-4abc-87bb-8ab6e95e9af2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4985, 100003, N'78f5ae83-52fb-4229-ad38-8df8570ce7f2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4986, 100003, N'd6b0b228-646a-47c9-a361-8efd57b2bd06', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4987, 100003, N'4e57b151-f2c9-40ff-b59d-9158fd33d899', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4988, 100003, N'12e2ecc5-d861-4680-9310-92422a3e2593', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4989, 100003, N'195ff984-63bb-42ff-a9af-963e7661ec63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4990, 100003, N'cb1c069e-5af0-4e65-b77c-97e1fb15779c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4991, 100003, N'336fdb14-6186-41c2-b2ff-98c99ea25c5f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4992, 100003, N'33b77acb-f6ad-4cfa-b919-99d5f5932851', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4993, 100003, N'11ab7a69-a705-4f46-8821-9bb3b7815a98', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4994, 100003, N'c17cd2c1-f273-4e77-a51e-9ca6a1b4c0b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4995, 100003, N'bfeda042-0064-4e1f-867a-9cfcea27daaa', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4996, 100003, N'dc666b63-21c9-4c3e-9bc8-9e05cd69d4b3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4997, 100003, N'4eeb1986-d74a-4aaa-90a4-9e37b0ec9fdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4998, 100003, N'f2630114-6cf4-431d-99f4-a3c79dadd2af', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (4999, 100003, N'0acce7c4-1da6-4276-a199-a4db6270bfd7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5000, 100003, N'e456ef1c-a28d-42a7-8324-ab5448f9139b', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5001, 100003, N'95220f17-16d4-44c8-ad10-ac6bb25fdfbc', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5002, 100003, N'e741ea2c-4b8a-4f2c-b06f-b0da4cab8695', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5003, 100003, N'9ad99f95-c82f-4b67-ac89-b46b5d95b255', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5004, 100003, N'd7382274-1bf0-4fc5-abcc-b8e725198bd8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5005, 100003, N'd6ff08d7-ed69-48ee-b7ff-b96f6db1a79f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5006, 100003, N'e5d585cd-594e-4546-baaf-885c9dca91b0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5007, 100003, N'322d8fea-9553-46c1-a83b-24276d046f53', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5008, 100003, N'8724f683-d67a-46a8-8fd2-86f3f9586735', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5009, 100003, N'05d45e13-6184-4085-b9b2-86015af49e11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5010, 100003, N'712d6299-495e-45ce-9010-20e4ad36834a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5011, 100003, N'a6618e04-9b2b-40c2-a947-c17f54da29de', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5012, 100003, N'5e566b61-2f3f-4f49-8a79-1c794e3cf1f7', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5013, 100003, N'fafd6bad-7ac7-4f9b-8dbb-bb844117369f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5014, 100003, N'bffe0f32-acf5-4f54-94be-fe54d946ea0a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5015, 100003, N'71a1d18f-85e1-4c77-ac51-fd731dcd925f', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5016, 100003, N'03ce07cd-f814-499f-82b7-1f0404328b63', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5017, 100003, N'1cfd0212-4eef-4656-a703-f40f737708ab', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5018, 100003, N'a6c247bc-d584-43a3-b995-f303e3b13c77', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5019, 100003, N'7745a1ab-9d96-4888-b8d1-f021a8593b9e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5020, 100003, N'055e9281-29db-478a-8d91-eda76013a1b2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5021, 100003, N'387aa8a0-35f2-4c32-8806-ece5fa6c7f60', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5022, 100003, N'17a1d12a-bef0-4e55-a011-ea7c5184ebf5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5023, 100003, N'ffc769fb-fe4f-4fa4-a6eb-e8f373f75243', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5024, 100003, N'5b42320e-6062-4383-b8f6-e3100ab201bd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5025, 100003, N'831becf0-0744-4fe4-b79c-dec135cee846', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5026, 100003, N'c1be620f-636b-413f-b857-dab1d1fff0ac', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5027, 100003, N'cf9f36ce-6028-47da-9f59-da543c45ebde', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5028, 100003, N'dac6e0f0-46e0-4a0e-be85-f4f4a4a02b25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5029, 100003, N'558d9955-927c-4078-91f0-d7ed9277877e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5030, 100003, N'11bd72fb-de7a-4aca-ac33-d600df3edb7c', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5031, 100003, N'd2ddd080-9cb4-41ce-866e-d3ed43d02936', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5032, 100003, N'bb6ab79b-3279-487e-a321-d3deb8cba545', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5033, 100003, N'928fb421-b72d-42d3-abf1-d310cdd8e790', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5034, 100003, N'98817ce8-2dd1-4eb1-9897-d2c5a3655d4d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5035, 100003, N'bbcd8435-f677-4dac-ac8a-cffce96bcd11', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5036, 100003, N'537a93c1-9b68-42cb-9a0e-c8b253dbafa2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5037, 100003, N'b7128c74-3b1a-47c4-851d-c211baa1fb0e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5038, 100003, N'06eb3687-d016-4597-9538-c1eaed785b50', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5039, 100003, N'd7c9f718-49fb-41e3-88a5-0197b286cd25', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5040, 100003, N'72fff920-bbac-437e-866b-05fc4a6b5ea0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5041, 100003, N'5fdd0965-6b67-4ded-bc61-0bd5b02643a3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5042, 100003, N'b2ada670-254e-4184-adcb-1040530e07b4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5043, 100003, N'6d02633e-d8ed-4965-ad93-125f7607ee31', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (5044, 100003, N'78d5d270-ecd3-4013-a306-d881b94b0bdf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6013, 101019, N'e8927213-f5cf-4199-9c56-1dafafad858e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6014, 101019, N'316659e2-1dd6-4440-a447-84ca923b4ff9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6015, 101019, N'30c9a3ca-f76d-43bc-b420-b9332aef57dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6016, 101019, N'2dcccf5e-605d-4b1a-a990-c3c4e07e5002', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (6017, 101019, N'c3b91724-4498-4d45-8e1f-f5db43ece46d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7013, 100003, N'316659e2-1dd6-4440-a447-84ca923b4ff9', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7036, 100003, N'30c9a3ca-f76d-43bc-b420-b9332aef57dd', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7046, 100003, N'e8927213-f5cf-4199-9c56-1dafafad858e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7057, 100003, N'c3b91724-4498-4d45-8e1f-f5db43ece46d', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7072, 100003, N'2dcccf5e-605d-4b1a-a990-c3c4e07e5002', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7073, 101081, N'fd671f2f-5b90-4de3-9a07-817b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7074, 101091, N'fd671f2f-5b90-4de3-9a07-917b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7075, 101091, N'fd671f2f-5b90-4de3-9a07-927b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7076, 101091, N'fd671f2f-5b90-4de3-9a07-937b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7077, 101091, N'fd671f2f-5b90-4de3-9a07-947b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7078, 101091, N'fd671f2f-5b90-4de3-9a07-957b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7079, 101091, N'fd671f2f-5b90-4de3-9a07-967b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7080, 101091, N'fd671f2f-5b90-4de3-9a07-977b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7081, 100032, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (7082, 10155, N'fd671f2f-5b91-4de3-9a07-817b4a3c8466', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8094, 100002, N'a620cac1-d220-4192-9480-3efd145bbbb1', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8095, 100002, N'9622eb79-12ad-460c-84ed-3f83b460bda0', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8106, 100002, N'cee99271-4d10-45b6-8714-5589d8730b45', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8138, 100002, N'fda86ec9-b74c-438f-8ac8-90ff2b31495e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8148, 100002, N'645aa9f7-f635-4816-967b-7fce6961b788', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8192, 100002, N'354c9a16-b1b1-4397-b4c9-fd474c70f3f4', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8201, 100002, N'dddd6466-a206-4d6a-93e7-f31f1243e003', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8202, 90000, N'ea8dd2bf-d37e-4a9d-96e9-fc5a712c9916', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8203, 101094, N'fd671f2f-5b91-4de3-9a07-997b4a3c8477', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8204, 102104, N'fd671f2f-5b91-4de3-9a07-337b4a3c8777', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8205, 101092, N'fd671f2f-5b91-4de3-9a07-337b4a3c8436', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8206, 101100, N'fd671f2f-5b91-4de3-9a07-337b4a3c8123', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8207, 101104, N'11a54559-a008-4bd7-9ace-05a0840bc70e', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8208, 101104, N'8abdd0ac-9b7f-44d8-8cb7-1ff822f4d8df', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8209, 101104, N'41f5a821-ebc9-47d7-a5eb-403d75a3a639', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8210, 101104, N'7eb32a97-5057-42bd-8978-bf4b34333345', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8211, 101104, N'95020697-9168-48f1-9d67-cf8b18a8f367', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8212, 101101, N'fd671f2f-5b91-4de3-9a07-337b4a3c8321', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8213, 101103, N'fd671f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8214, 101102, N'fd671f2f-5b91-4de3-9a07-337b4a3c5721', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8215, 102101, N'fd111f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8216, 102102, N'fd331f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8217, 102103, N'fd101f2f-5b91-4de3-9a07-337b4a3c3652', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8218, 103104, N'fd101f2f-5b91-4de3-9a07-337b4a3c3120', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8219, 103105, N'fd101f2f-5b91-4de3-9a07-337b4a3c3121', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8220, 103106, N'fd101f2f-5b91-4de3-9a07-337b4a3c3122', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8221, 103107, N'fd101f2f-5b91-4de3-9a07-337b4a3c3123', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8222, 103108, N'fd101f2f-5b91-4de3-9a07-337b4a3c3124', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8223, 103109, N'fd101f2f-5b91-4de3-9a07-337b4a3c3125', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8224, 103110, N'fd101f2f-5b91-4de3-9a07-337b4a3c3126', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8225, 101102, N'ed8409db-eeed-4915-9b3b-a650f0eb3aea', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8226, 101102, N'2806f1cd-9742-4811-aff4-1ba3268ca6e2', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8227, 101102, N'd84dd72d-7b49-42a8-8c05-f7ac1b89e292', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8228, 101102, N'15be47d8-f94e-4512-9077-ad9cacb9e204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8229, 101102, N'04c4ae31-23ca-4cf1-8057-c596d605ff56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8230, 101016, N'fd101f2f-5b91-4de3-9a07-337b4a3c3165', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8231, 101102, N'37a20e5c-61ce-4cbf-b8a4-f7dd46466e41', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8232, 101102, N'997b0595-b07b-49ee-9999-51ad34cd289a', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8233, 100062, N'd006adea-6c46-421a-96d6-2c90fc2b5679', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8234, 100062, N'532b7b55-c3d5-47ca-988d-7b7e6a3fc219', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8235, 100062, N'a9f6e6f8-a198-4009-9d3f-bbf255f240e3', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8236, 103108, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8237, 100003, N'502bc6d4-8e23-4a32-930c-f5b3b49bee09', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8238, 103108, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8239, 100003, N'3f937828-c86b-454b-a6f3-9db6bca39bb6', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8240, 100018, N'2619edd7-d221-43d7-832b-c1c761df8ac8', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8241, 103111, N'fd101f2f-5b91-4de3-9a07-337b4a3c3200', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8242, 103112, N'fd101f2f-5b91-4de3-9a07-337b4a3c3201', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8243, 103113, N'fd101f2f-5b91-4de3-9a07-337b4a3c3202', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8244, 103114, N'fd101f2f-5b91-4de3-9a07-337b4a3c3203', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8245, 103115, N'fd101f2f-5b91-4de3-9a07-337b4a3c3204', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8246, 103116, N'fd101f2f-5b91-4de3-9a07-337b4a3c3205', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8247, 103117, N'fd101f2f-5b91-4de3-9a07-337b4a3c3206', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8248, 103118, N'fd101f2f-5b91-4de3-9a07-337b4a3c3207', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8249, 103119, N'fd101f2f-5b91-4de3-9a07-337b4a3c3208', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8250, 103123, N'fd101f2f-5b91-4de3-9a07-337b4a3c3212', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8251, 103124, N'fd101f2f-5b91-4de3-9a07-337b4a3c3213', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8252, 103120, N'fd101f2f-5b91-4de3-9a07-337b4a3c3209', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8253, 103121, N'fd101f2f-5b91-4de3-9a07-337b4a3c3210', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8254, 103122, N'fd101f2f-5b91-4de3-9a07-337b4a3c3211', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8255, 103125, N'cf181131-0c18-4765-a227-1ce7eb5fc6cb', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8256, 103126, N'c1eb45b6-7253-4cdb-82a9-da1bdc358a56', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8257, 103127, N'07d389ff-9eab-4f08-9c39-fe29a5005033', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8258, 103128, N'23ecab55-eab6-49d7-a2f7-8fbeb7305436', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8259, 103129, N'74bf3653-7c42-48d7-8c76-0710c44c5189', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8260, 103130, N'fd101f2f-5b91-4de3-9a07-337b4a3c3601', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8261, 103131, N'fd101f2f-5b91-4de3-9a07-337b4a3c3602', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8262, 103132, N'81da3096-5ee0-43df-8561-79df89b346cf', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8263, 100018, N'ed89fcb1-6cba-4a58-ac13-1da7b1e897c5', 1)
INSERT INTO [ERPSettings].[FunctionalityConfig] ([Id], [IdRoleConfig], [IdFunctionality], [IsActive]) VALUES (8264, 101041, N'fe8641a3-25ac-467c-9e45-7bb77b77e51f', 1)
SET IDENTITY_INSERT [ERPSettings].[FunctionalityConfig] OFF
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Functionality] FOREIGN KEY ([IdFunctionnality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[FunctionnalityModule]
    ADD CONSTRAINT [FK_FunctionnalityModule_Module] FOREIGN KEY ([IdModule]) REFERENCES [ERPSettings].[Module] ([IdModule])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_RoleConfig] FOREIGN KEY ([IdRoleConfig]) REFERENCES [ERPSettings].[RoleConfig] ([Id])
ALTER TABLE [ERPSettings].[FunctionalityConfig]
    WITH NOCHECK ADD CONSTRAINT [FK_FonctionalityConfig_Functionality] FOREIGN KEY ([IdFunctionality]) REFERENCES [ERPSettings].[Functionality] ([IdFunctionality])
ALTER TABLE [ERPSettings].[Functionality]
    ADD CONSTRAINT [FK_Functionality_RequestType] FOREIGN KEY ([IdRequestType]) REFERENCES [ERPSettings].[RequestType] ([Id])
COMMIT TRANSACTION
