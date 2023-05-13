import SelectField from "./SelectField";
import {
  Alert,
  AlertDescription,
  AlertIcon,
  Button,
  Heading,
} from "@chakra-ui/react";
import NumberField from "./NumberField";
import useAxios from "@/hooks/useAxios";
import { difficultyOptions, typeOptions } from "@/models/Option";
import { useContext, useEffect, useState } from "react";
import LoadingSpinner from "./LoadingSpinner";
import { useRouter } from "next/router";
import useQuestion from "@/hooks/useQuestion";
import { AnswerContext } from "@/context/answer-context";
import { QuestionContext } from "@/context/question-context";

const Settings = () => {
  const { response, error, isLoading } = useAxios({ url: "/api_category.php" });

  const initState = {
    amount: "10",
    category: "",
    difficulty: "",
    type: "",
  };
  const [formData, setFormData] = useState(initState);
  const { amount, category, difficulty, type } = formData;
  const {
    fetchQuestions,
    error: questionsError,
    isLoading: questionIsLoading,
  } = useQuestion();

  const apiUrl = `/api.php?amount=${amount}${
    category
      ? difficulty
        ? type
          ? `&category=${category}&difficulty=${difficulty}&type=${type}`
          : `&category=${category}&difficulty=${difficulty}`
        : `&category=${category}`
      : ""
  }`;
  const router = useRouter();
  const { resetStates } = useContext(AnswerContext);
  const { dispatch } = useContext(QuestionContext);

  useEffect(() => {
    resetStates();
    dispatch({ type: "GET_QUESTIONS", payload: [] });
  }, []);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    const responseCode = await fetchQuestions(apiUrl);
    if (responseCode !== 1) router.push("/questions");
  };
  if (error) {
    return (
      <h2 className="font-bold text-lg text-red">
        Oops! Something went wrong.
      </h2>
    );
  }

  if (isLoading) {
    return <LoadingSpinner />;
  }
  return (
    <section className="w-full max-w-[40rem]">
      <Heading textAlign="center" size="lg" fontWeight="semibold">
        Settings
      </Heading>
      {questionsError && (
        <Alert status="error" my="1rem">
          <AlertIcon />
          <AlertDescription>{questionsError}</AlertDescription>
        </Alert>
      )}
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        <SelectField
          label="Category"
          options={response.trivia_categories}
          formData={formData}
          setFormData={setFormData}
        />
        <SelectField
          label="Difficulty"
          options={difficultyOptions}
          formData={formData}
          setFormData={setFormData}
        />
        <SelectField
          label="Type"
          options={typeOptions}
          formData={formData}
          setFormData={setFormData}
        />
        <NumberField formData={formData} setFormData={setFormData} />
        <Button
          w="full"
          colorScheme="blue"
          type="submit"
          isLoading={questionIsLoading}
          loadingText="Getting Started..."
        >
          Get Started
        </Button>
      </form>
    </section>
  );
};

export default Settings;
