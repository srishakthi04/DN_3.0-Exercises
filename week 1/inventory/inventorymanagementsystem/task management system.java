class Node {
    Task task;
    Node next;
    public Node(Task task) {
        this.task = task;
        this.next = null;
    }
}
public class TaskManagementSystem {
    private Node head;

    public TaskManagementSystem() {
        this.head = null;
    }
    public void addTask(Task task) {
        Node newNode = new Node(task);
        newNode.next = head;
        head = newNode;
    }
    public Task searchTask(int taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.taskId == taskId) {
                return current.task;
            }
            current = current.next;
        }
        return null;
    }
    public void traverseTasks() {
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
    }
    public void deleteTask(int taskId) {
        Node current = head;
        Node previous = null;

        while (current != null && current.task.taskId != taskId) {
            previous = current;
            current = current.next;
        }

        if (current == null) {
            System.out.println("Task not found.");
            return;
        }

        if (previous == null) {
            head = current.next;
        } else {
            previous.next = current.next;
        }
    }
    public static void main(String[] args) {
        TaskManagementSystem tms = new TaskManagementSystem();

        tms.addTask(new Task(1, "create", "Pending"));
        tms.addTask(new Task(2, "develop", "In Progress"));
        tms.addTask(new Task(3, "Test", "Completed"));

        System.out.println("All Tasks:");
        tms.traverseTasks();

        System.out.println("\nSearching for Task with ID 1:");
        System.out.println(tms.searchTask(1));

        System.out.println("\nDeleting Task with ID 3:");
        tms.deleteTask(3);

        System.out.println("\nAll Tasks after deletion:");
        tms.traverseTasks();
    }
}
class Task {
    int taskId;
    String taskName;
    String status;

    public Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
    }

    @Override
    public String toString() {
        return "taskId=" + taskId + ", taskName=" + taskName + ", status=" + status;
    }
}
