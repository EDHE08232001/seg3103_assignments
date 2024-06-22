
// Adapted from S. S. Somé
import java.awt.event.*;
import javax.swing.*;
import java.awt.*;

class EFrame extends JFrame {
  private JTextField year = new JTextField(4);
  private JButton quit = new JButton("Quit");
  private JButton find = new JButton("Find Easter Date");
  private JTextField res = new JTextField(30);
  private JPanel datepanel = new JPanel();
  private JPanel buttonpanel = new JPanel();

  // Constructor
  public EFrame(String title) {
    super(title);
    this.getContentPane().setLayout(new BorderLayout(10, 10));
    res.setEditable(false);
    datepanel.setLayout(new FlowLayout());
    datepanel.add(new Label("Year : "));
    datepanel.add(year);
    buttonpanel.setLayout(new FlowLayout());
    buttonpanel.add(quit);
    buttonpanel.add(find);
    this.getContentPane().add("North", datepanel);
    this.getContentPane().add("Center", res);
    this.getContentPane().add("South", buttonpanel);
    quit.addActionListener(new QuitAct());
    find.addActionListener(new FindAct());
  }

  private class QuitAct implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      System.exit(0);
    }
  }

  private class FindAct implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      int year_entered;
      // get the year entered in year field
      try {
        year_entered = Integer.parseInt(year.getText());
      } catch (NumberFormatException ex) {
        res.setText("Illegal arguments.");
        return;
      }

      // arguments are okay if we pass this point
      // use EasterCalculator to find result
      MyDate easterD = EasterCalculator.easterDate(year_entered);
      // show result
      if (easterD == null) {
        res.setText("Year out of bounds.");
      } else {
        res.setText("Easter Date is : " + easterD.toString());
      }
    }
  }
}
