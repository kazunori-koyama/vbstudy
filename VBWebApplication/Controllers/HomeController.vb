Public Class HomeController
    Inherits System.Web.Mvc.Controller

    Function Index() As ActionResult


        Dim entities As New vbtestEntities
        Dim record As New m_code

        ' レコード追加
        record.code_bunrui = "新規分類"
        record.code_value = "1"
        record.code_text = "分類1"
        record.start_date = DateTime.Now

        entities.m_code.Add(record)
        entities.SaveChanges()

        Return View()
    End Function

    Function About() As ActionResult
        ViewData("Message") = "Your application description page."

        Return View()
    End Function

    Function Contact() As ActionResult
        ViewData("Message") = "Your contact page."

        Return View()
    End Function
End Class
