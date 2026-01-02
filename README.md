# How to Run FoodExpress in Eclipse

Follow these steps one by one to set up and run the project.

## Step 1: Database Setup
1.  Open your **MySQL Workbench** or command line.
2.  Login to your MySQL server.
3.  Open the file `db.sql` located in your project folder (`f:\food\db.sql`).
4.  Execute the entire script to create the `food_delivery_db` database and all necessary tables.
    *   *Tip*: In Workbench, click the lightning bolt icon ⚡ to run all.

## Step 2: Import Project in Eclipse
1.  Open **Eclipse IDE**.
2.  Go to **File** > **Open Projects from File System...**
3.  Click **Directory...** and select the `f:\food` folder.
4.  Click **Finish**.
    *   *Note*: If Eclipse doesn't recognize it as a web project immediately, you may need to convert it: Right-click project > Properties > Project Facets > Convert to Faceted Form > Check "Dynamic Web Module" and "Java".

## Step 3: Add Dependencies (If not using Maven)
Since this is a raw project, ensure you have the `mysql-connector-java.jar` (driver) and `servlet-api.jar` in your build path.
1.  Right-click the project > **Build Path** > **Configure Build Path**.
2.  Go to the **Libraries** tab.
3.  Click **Add External JARs** and add your MySQL Connector JAR.
4.  Ensure **Apache Tomcat** is added under "Runtime" or "Server Library".

## Step 4: Configure DB Connection
1.  Open `src/main/java/com/food/util/DBConnection.java`.
2.  Check the `URL`, `USERNAME`, and `PASSWORD`.
3.  Update them if your MySQL credentials are different (e.g., if your password is not empty).

## Step 5: Run the Project
1.  In the **Project Explorer**, expand `src/main/webapp`.
2.  Right-click on `home.jsp` (or `login.jsp`).
3.  Select **Run As** > **Run on Server**.
4.  Select your Tomcat Server (e.g., Tomcat v9.0) and click **Finish**.
5.  The application should open in the Eclipse browser or your default browser.

## Step 6: Test Access
- **Customer**: Register a new user.
- **Delivery Agent**: Register with role "Delivery Agent".
- **Admin**: You may need to manually insert an Admin user in the DB or use a registration page if configured.
