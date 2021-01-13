package persistence;

public class DBManager {
    private static DBManager instance = null;
    static DBSource dataSource;

    static {
        try {
            Class.forName("org.postgresql.Driver");
            dataSource = new DBSource("jdbc:postgresql://localhost:5432/mannaiaAchiSoIo", "postgres", "postgres");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DBManager getInstance() {
        if (instance == null) {
            instance = new DBManager();
        }
        return instance;
    }

    private DBManager() {
    }

    public static DBSource getDataSource() {
        return dataSource;
    }


}
