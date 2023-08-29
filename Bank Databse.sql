-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bankingapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bankingapp` ;

-- -----------------------------------------------------
-- Schema bankingapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bankingapp` DEFAULT CHARACTER SET utf8 ;
USE `bankingapp` ;

-- -----------------------------------------------------
-- Table `bankingapp`.`Branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankingapp`.`Branches` ;

CREATE TABLE IF NOT EXISTS `bankingapp`.`Branches` (
  `BranchID` INT NOT NULL AUTO_INCREMENT,
  `BranchName` VARCHAR(30) NOT NULL,
  `BranchCity` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`BranchID`))
ENGINE = InnoDB;

INSERT INTO `bankingapp`.`Branches` (`BranchName`,`BranchCity`) VALUES ('MBS Bank Los Angeles','Los Angeles');
INSERT INTO `bankingapp`.`Branches` (`BranchName`,`BranchCity`) VALUES ('MBS Bank Washington DC','Washington DC');
INSERT INTO `bankingapp`.`Branches` (`BranchName`,`BranchCity`) VALUES ('MBS Bank Florence','Florence');
INSERT INTO `bankingapp`.`Branches` (`BranchName`,`BranchCity`) VALUES ('MBS Bank London','London');
INSERT INTO `bankingapp`.`Branches` (`BranchName`,`BranchCity`) VALUES ('MBS Bank London','London');


-- -----------------------------------------------------
-- Table `bankingapp`.`Bankers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankingapp`.`Bankers` ;

CREATE TABLE IF NOT EXISTS `bankingapp`.`Bankers` (
  `BankerID` INT NOT NULL AUTO_INCREMENT,
  `BankerName` VARCHAR(30) NOT NULL,
  `BankerManager` INT NOT NULL,
  `BranchID` INT NOT NULL,
  PRIMARY KEY (`BankerID`),
  INDEX `fk_Bankers_Branches1_idx` (`BranchID` ASC) VISIBLE,
  CONSTRAINT `fk_Bankers_Branches1`
    FOREIGN KEY (`BranchID`)
    REFERENCES `bankingapp`.`Branches` (`BranchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `bankingapp`.`Bankers` (`BankerName`,`BankerManager`,`BranchID`) VALUES ('Ben Miflin',101,1);
INSERT INTO `bankingapp`.`Bankers` (`BankerName`,`BankerManager`,`BranchID`) VALUES ('Hans Krebbs',102,2);
INSERT INTO `bankingapp`.`Bankers` (`BankerName`,`BankerManager`,`BranchID`) VALUES ('Mary Jones',103,3);
INSERT INTO `bankingapp`.`Bankers` (`BankerName`,`BankerManager`,`BranchID`) VALUES ('Jane Hughes',104,4);
INSERT INTO `bankingapp`.`Bankers` (`BankerName`,`BankerManager`,`BranchID`) VALUES ('Bill Pirie',105,5);


-- -----------------------------------------------------
-- Table `bankingapp`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankingapp`.`Customers` ;

CREATE TABLE IF NOT EXISTS `bankingapp`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(30) NOT NULL,
  `CustomerCity` VARCHAR(20) NOT NULL,
  `CustomerAddress` VARCHAR(30) NOT NULL,
  `BankerID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`, `BankerID`),
  INDEX `fk_Customers_Bankers1_idx` (`BankerID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Bankers1`
    FOREIGN KEY (`BankerID`)
    REFERENCES `bankingapp`.`Bankers` (`BankerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `bankingapp`.`Customers` (`CustomerName`,`CustomerCity`,`CustomerAddress`,`BankerID`) VALUES ('George Miller','Los Angeles','Biden Road',1);
INSERT INTO `bankingapp`.`Customers` (`CustomerName`,`CustomerCity`,`CustomerAddress`,`BankerID`)  VALUES ('Jessica Jones','Washington DC','JFK Avenue',2);
INSERT INTO `bankingapp`.`Customers` (`CustomerName`,`CustomerCity`,`CustomerAddress`,`BankerID`)  VALUES ('Denzel Washington','Florence','Via Veneto',3);
INSERT INTO `bankingapp`.`Customers` (`CustomerName`,`CustomerCity`,`CustomerAddress`,`BankerID`)  VALUES ('George Clooney','London','Courtfield Gardens',4);
INSERT INTO `bankingapp`.`Customers` (`CustomerName`,`CustomerCity`,`CustomerAddress`,`BankerID`)  VALUES ('Cameron Jones','London','Ommaney Road',5);


-- -----------------------------------------------------
-- Table `bankingapp`.`Accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankingapp`.`Accounts` ;

CREATE TABLE IF NOT EXISTS `bankingapp`.`Accounts` (
  `AccountNumber` INT NOT NULL AUTO_INCREMENT,
  `AccountBalance` DECIMAL(10,2) NOT NULL,
  `AccountType` VARCHAR(20) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`AccountNumber`, `CustomerID`),
  INDEX `fk_Accounts_Customers1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Accounts_Customers1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `bankingapp`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (3447.01, 'Current Account',1);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (4567.01, 'Saving Account',2);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (5647.20, 'Saving Account',3);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (15222.06, 'Current Account',2);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (7589.19, 'Current Account',3);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (9347.21, 'Saving Account',4);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (970.12, 'Current Account',4);
INSERT INTO `bankingapp`.`Accounts` (`AccountBalance`, `AccountType`,`CustomerID`) VALUES (1020.76, 'Current Account',5);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- • Display the names of those customers who do not live in London.

SELECT  
    `CustomerName`
FROM
    `bankingapp`.`Customers`
WHERE
    `CustomerCity` != 'London';

-- • Display the total number of accounts.

SELECT 
    COUNT(`AccountNumber`)
FROM
    `bankingapp`.`Accounts`;

-- • Return the total value for current accounts.

SELECT 
    sum(`AccountBalance`) AS CombinedBalanceCurrent
FROM
    `bankingapp`.`Accounts`
WHERE
	`AccountType` = 'Current Account';

-- • Display the average account value for customers.

SELECT 
    AVG(`AccountBalance`) AS AverageBudget
FROM
    `bankingapp`.`Accounts`;

-- • Produce a query to show by how much the account balance of customers with a below average
-- account balance differs from the average.

SELECT 
    `AccountBalance` < (SELECT AVG(`AccountBalance`)
        FROM
            `bankingapp`.`Accounts`) AS BelowAVGBalance
FROM
    `bankingapp`.`Accounts`;


-- • Select the total value of the accounts for Los Angeles and Washington only.

SELECT 
    SUM(`AccountBalance`) AS TotalBalanceUS
FROM
    `bankingapp`.`Accounts`, `bankingapp`.`Customers`
ONLY WHERE
    `CustomerCity` = 'Los Angeles' OR `CustomerCity` = 'Washington DC';
	
-- • Return the names of bankers in alphabetical order.

SELECT 
    `BankerName` AS BankersEmployed
FROM
    `bankingapp`.`Bankers`
ORDER BY `BankerName`;

-- • Return customers ID with a saving account only, if any.

SELECT 
   `CustomerID` AS SavingAccountNames
FROM
	`bankingapp`.`Accounts`
WHERE
    `AccountType` = 'Saving Account';

-- • Return the cities of branches without a Manager, if any.

SELECT 
   `BranchCity` AS NoManagerBranch
FROM
	`bankingapp`.`Branches`, `bankingapp`.`Bankers`
WHERE
    `BankerManager` IS NULL;
