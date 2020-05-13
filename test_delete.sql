CREATE TABLE test_p (
    test_id INT PRIMARY KEY IDENTITY(1,1),
    var1 VARCHAR(max),
    var2 VARCHAR(max),
    var3 VARCHAR(max),

    
)

CREATE TABLE test_f (
    another_id INT PRIMARY KEY IDENTITY(1,1) ,
    arg1 VARCHAR(max),
    arg2 VARCHAR(max),
    test_id INT, 

    
    FOREIGN KEY (test_id) REFERENCES test_p(test_id) ON DELETE CASCADE
)

INSERT INTO test_p
(var1, var2, var3)
VALUES 
('asd', 'fgh', 'jkl'),
('qwe', 'rty', 'uio')

INSERT INTO test_f
(arg1, arg2, test_id)
VALUES 
('10', '20', 1),
('40', '50', 2)

SELECT * FROM test_p
SELECT * FROM test_f

DELETE FROM test_p WHERE test_id = 1

DELETE FROM test_f WHERE test_id = 1

DROP TABLE test_f
DROP TABLE test_p

