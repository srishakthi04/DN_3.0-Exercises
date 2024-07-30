public class EmployeeManagementSystem {
    private Employee[] employees;
    private int count;
    public EmployeeManagementSystem(int size) {
        employees = new Employee[size];
        count = 0;
    }
    public void addEmployee(Employee employee) {
        if (count < employees.length) {
            employees[count++] = employee;
        } else {
            System.out.println("Array is full. Cannot add more employees.");
        }
    }
    public Employee searchEmployee(int employeeId) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == employeeId) {
                return employees[i];
            }
        }
        return null;
    }
    public void traverseEmployees() {
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }
    public void deleteEmployee(int employeeId) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == employeeId) {
                employees[i] = employees[count - 1];
                employees[count - 1] = null;
                count--;
                return;
            }
        }
        System.out.println("Employee not found.");
    }
    public static void main(String[] args) {
        EmployeeManagementSystem ems = new EmployeeManagementSystem(5);

        ems.addEmployee(new Employee(1, "shyamala", "Manager", 85000));
        ems.addEmployee(new Employee(2, "thara", "Developer", 70000));
        ems.addEmployee(new Employee(3, "vijay", "Designer", 50000));

        System.out.println("All Employees:");
        ems.traverseEmployees();

        System.out.println("\nSearch Employee with ID 2:");
        System.out.println(ems.searchEmployee(2));

        System.out.println("\nDelete Employee with ID 2:");
        ems.deleteEmployee(2);

        System.out.println("\nAll Employees after deletion:");
        ems.traverseEmployees();
    }
}
class Employee {
    int employeeId;
    String name;
    String position;
    double salary;
    public Employee(int employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }
    @Override
    public String toString() {
        return "employeeId=" + employeeId + ", name=" + name + ", position=" + position + ", salary=" + salary ;
    }
}
