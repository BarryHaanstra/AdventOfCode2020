import Foundation

let input = """
1706
1466
1427
1744
1684
1386
2001
1750
1753
1770
1559
1616
1408
1860
1940
2002
1862
1918
1456
1209
1840
1462
1783
1644
1901
1791
1506
2005
1338
1383
1420
1631
1784
1897
1771
1588
1955
1937
1392
1396
1803
1429
1407
1698
1562
1913
1678
1198
1398
1703
1831
1489
1782
1864
1708
1397
1915
1953
1395
1610
1549
1564
1973
1931
2009
1980
1800
1443
1993
1900
1964
1581
1904
1665
1567
1057
1805
1402
1878
1729
1825
1682
1719
1469
1004
1591
1594
811
1523
1424
1756
373
1442
1718
1411
1892
1820
1977
1871
1890
1653
1372
1475
1476
1422
2004
1755
1676
639
1425
1853
1712
1525
1514
1455
1658
1963
1579
1861
1458
1474
1613
1681
1586
1441
1499
1865
1735
1989
1952
792
1669
1509
1481
1893
1445
1834
1779
1732
1826
1595
1829
449
1920
1707
1780
1935
1867
1769
1107
919
1382
1604
1875
1453
1496
1946
1659
1570
1692
1630
1638
1922
1691
1580
1880
1482
1762
1775
1376
1434
1856
1971
1646
1951
1416
1889
1773
1814
1471
1488
1736
1743
1459
1389
1498
1663
1611
1727
1699
1624
1511
1767
1754
1785
1491
1235
1510
1500
1485
"""

let inputArray = input.split(whereSeparator: \.isNewline).map { Int($0)! }

print(calculate2(withInput: inputArray))
print(calculate2brute(withInput: inputArray))
print(calculate3(withInput: inputArray))

func calculate2(withInput input: Array<Int>) -> Int {
    // May be incorrect if there is more than 1 possible outcome, works for this dataset
    return input.map { return 2020 - $0 }.filter { input.contains($0) }.reduce(1, { a, b in
        a * b
    })
}


func calculate2brute(withInput input: Array<Int>) -> Int {
    for input1 in input {
        for input2 in input {
            if input1 + input2 == 2020 {
                return input1 * input2
            }
        }
    }
    
    return -1
}


func calculate3(withInput input: Array<Int>) -> Int {
    for input1 in input {
        for input2 in input {
            for input3 in input {
                if input1 + input2 + input3 == 2020 {
                    return input1 * input2 * input3
                }
            }
        }
    }
    
    return -1
}
