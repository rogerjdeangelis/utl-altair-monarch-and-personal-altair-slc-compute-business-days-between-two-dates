%let pgm=utl-altair-monarch-and-personal-altair-slc-compute-business-days-between-two-dates;

%stop_submission;

Altair Monarch and personal altair slc compute business days between two dates

Too long to post on a listserv, see github

gthub
https://tinyurl.com/bdh262cr
https://github.com/rogerjdeangelis/utl-altair-monarch-and-personal-slc-reading-and-writing-dbf-files

TWO SOLUTIONS

  1 personal slc
  2 monarch (see link)
    https://tinyurl.com/kw75658e

community.altair
https://tinyurl.com/kw75658e
https://community.altair.com/discussion/63717/monarch-classic-how-to-capture-business-days-between-two-dates?tab=accepted#latest

The number of business days is 22

   DTC        NAME        Busdays

2025-01-15    Wednesday   1
2025-01-16    Thursday    2
2025-01-17    Friday      3

2025-01-18    Saturday        Very easy to add to business if open on weekends
2025-01-19    Sunday

2025-01-20    Monday          MLK  (not a business day)

2025-01-21    Tuesday     4
2025-01-22    Wednesday   5  Weekdaya are Business Days
2025-01-23    Thursday    6
2025-01-24    Friday      7

2025-01-25    Saturday
2025-01-26    Sunday

2025-01-27    Monday      8
2025-01-28    Tuesday     9   Weekdays
2025-01-29    Wednesday  10
2025-01-30    Thursday   11
2025-01-31    Friday     12

2025-02-01    Saturday
2025-02-02    Sunday

2025-02-03    Monday     13
2025-02-04    Tuesday    14   Weekdays
2025-02-05    Wednesday  15
2025-02-06    Thursday   16
2025-02-07    Friday     17

2025-02-08    Saturday
2025-02-09    Sunday

2025-02-10    Monday     18
2025-02-11    Tuesday    19
2025-02-12    Wednesday  20  Weekdays
2025-02-13    Thursday   21
2025-02-14    Friday     22

2025-02-15    Saturday


/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

work.calendar

Obs       DTC

  1    2025-01-15
  2    2025-01-16
  3    2025-01-17
  4    2025-01-18
  5    2025-01-19
       ...
 28    2025-02-11
 29    2025-02-12
 30    2025-02-13
 31    2025-02-14
 32    2025-02-15


&_init;
data calendar;
   informat dtc $10.;
   input dtc @@;
cards4;
2025-01-15 2025-01-31
2025-01-16 2025-02-01
2025-01-17 2025-02-02
2025-01-18 2025-02-03
2025-01-19 2025-02-04
2025-01-20 2025-02-05
2025-01-21 2025-02-06
2025-01-22 2025-02-07
2025-01-23 2025-02-08
2025-01-24 2025-02-09
2025-01-25 2025-02-10
2025-01-26 2025-02-11
2025-01-27 2025-02-12
2025-01-28 2025-02-13
2025-01-29 2025-02-14
2025-01-30 2025-02-15
;;;;
run;quit;

/*                                         _       _
/ |  _ __   ___ _ __ ___  ___  _ __   __ _| |  ___| | ___
| | | `_ \ / _ \ `__/ __|/ _ \| `_ \ / _` | | / __| |/ __|
| | | |_) |  __/ |  \__ \ (_) | | | | (_| | | \__ \ | (__
|_| | .__/ \___|_|  |___/\___/|_| |_|\__,_|_| |___/_|\___|
    |_|
*/

&_init_;
proc format;
 invalue $holiday
  '2025-01-01' = 1   /* NEWYEAR        */
  '2025-01-20' = 1   /* MLK            */
  '2025-02-17' = 1   /* USPRESIDENTS   */
  '2025-04-20' = 1   /* EASTER         */
  '2025-05-26' = 1   /* MEMORIAL       */
  '2025-07-04' = 1   /* USINDEPENDENCE */
  '2025-09-01' = 1   /* LABOR          */
  '2025-11-11' = 1   /* VETERANS       */
  '2025-11-27' = 1   /* THANKSGIVING   */
  '2025-12-25' = 1   /* CHRISTMAS      */
  other        = 0   /* FALSE          */
  ;
run;quit;

OUTPUT
======

&_init_;
data workdays;
   retain busdays 0;

   set calendar end=dne;
   dtn=input(dtc,e8601da.);

   /*-- sum mon-fri days                         --*/
   if weekday(dtn) in  (2,3,4,5,6)
      then busdays=busdays+1;

   /*-- subtract holidays if it falls on mon-fri --*/
   if weekday(dtn) in (2,3,4,5,6) and
       input(dtc,$holiday.) then busdays=busdays-1;

   if dne then put "number of busdays= " busdays;
run;quit;


OUTPUT
======

number of busdays= 22


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

