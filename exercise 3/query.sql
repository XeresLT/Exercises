SELECT nvl(max_acc,
           min_acc),
       max_amt,
       max_amt_date,
       min_amt,
       min_amt_date
  FROM (SELECT max_acc,
               max_amt,
               max_amt_date
          FROM (SELECT account_number max_acc,
                       transaction_amt max_amt,
                       transaction_date max_amt_date,
                       ROW_NUMBER() over(PARTITION BY account_number ORDER BY transaction_amt DESC) AS rn_max_amt
                  FROM TRANSACTION_TABLE
                 WHERE transaction_date > SYSDATE - 7) a
         WHERE rn_max_amt = 1) max_a
  FULL OUTER JOIN (SELECT min_acc,
                          min_amt,
                          min_amt_date
                     FROM (SELECT account_number min_acc,
                                  transaction_amt min_amt,
                                  transaction_date min_amt_date,
                                  ROW_NUMBER() over(PARTITION BY account_number ORDER BY transaction_amt, transaction_date DESC) AS rn_min_amt
                             FROM TRANSACTION_TABLE
                            WHERE transaction_date > SYSDATE - 30)
                    WHERE rn_min_amt = 1) min_a
    ON min_a.min_acc = max_a.max_acc
